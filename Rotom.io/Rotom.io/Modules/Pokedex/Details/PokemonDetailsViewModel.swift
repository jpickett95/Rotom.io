//
//  PokemonDetailsViewModel.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 10/24/24.
//

// MARK: Pokemon Details View Model
import Foundation


// MARK: - - View Model
class PokemonDetailsViewModel: ObservableObject {
    
    
    // MARK: - -- Properties
    private let networkManager: Networking & JSONDecoding
    let pokemonEntry: PokemonEntry
    var settings: Settings
    var games: [String] {
        return settings.game.versions
    }
    @Published var pokemon: Pokemon?
    @Published var officialArtwork: Data?
    @Published var shinyArtwork: Data?
    @Published var showShinyArtwork: Bool = false
    @Published var species: PokemonSpecies?
    @Published var selectedversion: String?
    @Published var abilities = [String: Ability]()
    @Published var damageRelations = [String: Float]()
    
    // MARK: - -- Lifecycle
    init(networkManager: Networking & JSONDecoding, entry: PokemonEntry, settings: Settings) {
        self.networkManager = networkManager
        self.pokemonEntry = entry
        self.settings = settings
        selectedversion = games.first
        
        Task {
            await getPokemon()
            await getArtwork()
            await getSpecies()
            await getAbilities()
            await getDamageRelations()
        }
    }
    
    @MainActor
    func getPokemon() async {
        do {
            let pokemonURL = pokemonEntry.pokemonSpecies.url.replacingOccurrences(of: "-species", with: "")
            
            let data = try await networkManager.request(endpoint: ApiResponseEndpoint.resource(baseURL: pokemonURL, path: nil))
            //print(data)
            
            let pokemon = try await networkManager.decode(data: data, modelType: Pokemon.self)
            //print(pokemon)
            
            self.pokemon = pokemon
            
        } catch {
            print("PokemonDetailsVM - getPokemon: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func getArtwork() async {
        do {
            guard let regularURL = pokemon?.sprites.other.officialArtwork.frontDefault, let shinyURL = pokemon?.sprites.other.officialArtwork.frontShiny else { return }
            
            let regularData = try await networkManager.getData(urlPath: regularURL)
            self.officialArtwork = regularData
                        
            let shinyData = try await networkManager.getData(urlPath: shinyURL)
            self.shinyArtwork = shinyData
        } catch {
            print("PokemonDetailsVM - getArtwork: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func getSpecies() async {
        do {
            let speciesURL = pokemonEntry.pokemonSpecies.url
            let data = try await networkManager.request(endpoint: ApiResponseEndpoint.resource(baseURL: speciesURL, path: nil))
            let species = try await networkManager.decode(data: data, modelType: PokemonSpecies.self)
            self.species = species
            
        } catch {
            print("PokemonDetailsVM - getSpecies: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func getAbilities() async {
        do {
            guard let abilities = pokemon?.abilities else {return}
            for pokemonAbility in abilities {
                let abilityURL = pokemonAbility.ability.url
                let data = try await networkManager.request(endpoint: ApiResponseEndpoint.resource(baseURL: abilityURL, path: nil))
                let ability = try await networkManager.decode(data: data, modelType: Ability.self)
                self.abilities[pokemonAbility.ability.name] = ability
            }
            
        } catch {
            print("PokemonDetailsVM - getAbilities: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func getDamageRelations() async {
        do {
            guard let pokemonTypes = pokemon?.types else {return}
            var types = [TypeData]()
            for pokemonType in pokemonTypes {
                let typeURL = pokemonType.type.url
                let data = try await networkManager.request(endpoint: ApiResponseEndpoint.resource(baseURL: typeURL, path: nil))
                let type = try await networkManager.decode(data: data, modelType: TypeData.self)
                types.append(type)
            }
            
            for type in types {
                let damageRelations = type.damageRelations
                
                for typeName in damageRelations.noDamageFrom {
                    if let currentValue = self.damageRelations[typeName.name] {
                        self.damageRelations[typeName.name] = currentValue * 0
                    } else {
                        self.damageRelations[typeName.name] = 0
                    }
                }
                
                for typeName in damageRelations.halfDamageFrom {
                    if let currentValue = self.damageRelations[typeName.name] {
                        self.damageRelations[typeName.name] = currentValue * 0.5
                    } else {
                        self.damageRelations[typeName.name] = 0.5
                    }
                }
                
                for typeName in damageRelations.doubleDamageFrom {
                    if let currentValue = self.damageRelations[typeName.name] {
                        self.damageRelations[typeName.name] = currentValue * 2
                    } else {
                        self.damageRelations[typeName.name] = 2
                    }
                }
            }
            
        } catch {
            print("PokemonDetailsVM - getDamageRelations: \(error.localizedDescription)")
        }
    }
    
    func getTypeColor(_ type: String) -> PokemonTypeColor {
        switch(type) {
        case "normal":
            .normal
        case "fire":
            .fire
        case "water":
            .water
        case "electric":
            .electric
        case "grass":
            .grass
        case "ice":
            .ice
        case "fighting":
            .fighting
        case "poison":
            .poison
        case "ground":
            .ground
        case "flying":
            .flying
        case "psychic":
            .psychic
        case "bug":
            .bug
        case "dark":
            .dark
        case "steel":
            .steel
        case "rock":
            .rock
        case "ghost":
            .ghost
        case "dragon":
            .dragon
        case "fairy":
            .fairy
        case "stellar":
            .stellar
        default:
            .unknown
        }
    }
    
    func getFlavorText() -> String {
        let englishFlavorTexts = species?.flavorTextEntries.filter({ $0.language.name == "en" })
        let versionFlavorTexts = englishFlavorTexts?.filter({ $0.version.name == selectedversion })
        
        if versionFlavorTexts?.count ?? 0 > 0 {
            let flavorText = versionFlavorTexts?.first?.flavorText ?? "No information available..."
            return flavorText.replacingOccurrences(of: "\n", with: " ")
        } else {
            return englishFlavorTexts?.last?.flavorText.replacingOccurrences(of: "\n", with: " ") ?? "No information available..."
        }
    }
    
    func getHeightWeight(_ value: Int, isHeight: Bool) -> String {
        if isHeight {
            let meters = Float(value) / 10
            let inches = Float(value) * 3.937
            let feet = inches / 12
            return "\(String(format: "%.1f", meters)) m\t-\t\(Int(feet))' \(Int(inches.truncatingRemainder(dividingBy: 12).rounded()))\""
        } else {
            let kilograms = Float(value) / 10
            let pounds = Float(value) / 4.536
            return "\(String(format: "%.1f", kilograms)) kg\t-\t\(String(format: "%.1f",pounds)) lbs"
        }
    }
}
