//
//  PokedexViewModel.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 10/16/24.
//

// MARK: - Pokedex View Model
import Foundation
import SwiftUICore

// MARK: - - View Model
class PokedexViewModel: ObservableObject {
    
    
    // MARK: - -- Properties
    private let networkManager: Networking & JSONDecoding
    var settings: Settings
    @Published var pokedexes = [CustomPokedex]()
    @Published var error: (any Error)?
    @Published var presentAlert: Bool = false
    
    // MARK: - -- Lifecycle
    init(networkManager: Networking & JSONDecoding, settings: Settings) {
        self.networkManager = networkManager
        self.settings = settings
        print("PokedexVM: \(settings.game.name)")
        
        Task {
            await getPokedexes()
        }

    }
    
    // MARK: - -- Methods
    @MainActor
    func getPokedexes() async {
        do {
            var pokedexes = [CustomPokedex]()
            
            for pokedexID in settings.game.pokedexIDs {
                let data = try await networkManager.request(endpoint: PokeAPIEndpoint.resource(path: Path.pokedex, id: pokedexID))
                
                let pokedex = try await networkManager.decode(data: data, modelType: Pokedex.self)
                //print(pokedex)
                let name = pokedex.name.replacingOccurrences(of: "-", with: " ").capitalized

                var pokemonEntries = [PokedexPokemon]()
                for entry in pokedex.pokemonEntries {
                    let speciesData = try await networkManager.request(endpoint: ApiResponseEndpoint.resource(baseURL: entry.pokemonSpecies.url, path: nil))
                    
                    let species = try await networkManager.decode(data: speciesData, modelType: PokemonSpecies.self)
                    
                    let pokemonData = try await networkManager.request(endpoint: PokeAPIEndpoint.resource(path: Path.pokemon, id: species.id))
                    
                    let pokemon = try await networkManager.decode(data: pokemonData, modelType: Pokemon.self)
                    print(pokemon)
                    pokemonEntries.append( PokedexPokemon(name: entry.pokemonSpecies.name, spriteURL: pokemon.sprites.frontDefault))
                }
                    
                let customPokedex = CustomPokedex(id: pokedex.id,name: name, pokemon: pokemonEntries)
                print(customPokedex)
                pokedexes.append(customPokedex)
            }
            self.pokedexes = pokedexes
        } catch {
            print(error.localizedDescription)
            self.error = error
            self.presentAlert = true
        }
    }
    
    func getSpriteURL(_ pokemonName: String) async -> String {
        do {
            let data = try await networkManager.request(endpoint: PokeAPIEndpoint.resource(path: Path.pokemon, name: pokemonName))
            
            let pokemon = try await networkManager.decode(data: data, modelType: Pokemon.self)
            return pokemon.sprites.frontDefault
        } catch {
            print(error.localizedDescription)
        }
        return ""
    }
}
