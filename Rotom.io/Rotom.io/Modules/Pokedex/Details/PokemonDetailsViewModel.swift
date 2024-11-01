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
    @Published var types = [String]()
    @Published var species: PokemonSpecies?
    @Published var selectedversion: String?
    
    // MARK: - -- Lifecycle
    init(networkManager: Networking & JSONDecoding, entry: PokemonEntry, settings: Settings) {
        self.networkManager = networkManager
        self.pokemonEntry = entry
        self.settings = settings
        selectedversion = games.first
        
        Task {
            await getPokemon()
            await getTypes()
            await getArtwork()
            await getSpecies()
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
    func getTypes() {
        if let type1 = pokemon?.types.first?.type.name, let type2 = pokemon?.types.last?.type.name {
            types.append(type1)
            types.append(type2)
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
