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
    @Published var pokedexes = [Pokedex]()
    @Published var sprites: [String: Data] = [:]
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
            
            for pokedexID in settings.game.pokedexIDs {
                let pokedex = try await getPokedex(pokedexID)
                self.pokedexes.append(pokedex)
            }
            
            for pokedex in pokedexes {
                for pokemon in pokedex.pokemonEntries {
                    try await getSpriteURL(pokemon.pokemonSpecies.name, pokemon.pokemonSpecies.url)
                }
            }
            
        } catch {
            print("getPokedexes \(error.localizedDescription)")
            self.error = error
            self.presentAlert = true
        }
    }
    
    func getPokedex(_ pokedexID: Int) async throws -> Pokedex {
        let data = try await networkManager.request(endpoint: PokeAPIEndpoint.resource(path: Path.pokedex, id: pokedexID))
        let pokedex = try await networkManager.decode(data: data, modelType: Pokedex.self)
        return pokedex
    }
    
    @MainActor
    func getSpriteURL(_ species: String, _ speciesURL: String) async throws {
        do {
            let pokemonURL = speciesURL.replacingOccurrences(of: "-species", with: "")
            
            let data = try await networkManager.request(endpoint: ApiResponseEndpoint.resource(baseURL: pokemonURL, path: nil))
            
            let pokemon = try await networkManager.decode(data: data, modelType: Pokemon.self)
            let sprite = pokemon.sprites.frontDefault
            print(sprite)
            self.sprites[species] = try await networkManager.getData(urlPath: sprite)
        } catch {
            print("getSpriteURL: \(error.localizedDescription)")
        }
    }
}
