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
    @Published var pokemon: Pokemon?
    @Published var officialArtwork: Data?
    
    // MARK: - -- Lifecycle
    init(networkManager: Networking & JSONDecoding, entry: PokemonEntry) {
        self.networkManager = networkManager
        self.pokemonEntry = entry
        
        Task {
            await getPokemon()
            await getOfficialArtwork()
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
    func getOfficialArtwork() async {
        do {
            guard let url = pokemon?.sprites.other.officialArtwork.frontDefault else { return }
            
            let data = try await networkManager.getData(urlPath: url)
            self.officialArtwork = data
        } catch {
            print("PokemonDetailsVM - getOfficialArtwork: \(error.localizedDescription)")
        }
    }
}
