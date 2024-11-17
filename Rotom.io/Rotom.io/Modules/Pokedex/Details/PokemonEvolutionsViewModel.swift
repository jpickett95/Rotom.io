//
//  PokemonEvolutionsViewModel.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 11/4/24.
//

import Foundation

class PokemonEvolutionsViewModel: ObservableObject {
    private let networkManager: Networking & JSONDecoding
    let species: PokemonSpecies
    @Published var evolutionChain: EvolutionChain?
    @Published var evolutionChainDict: [String: [String: [EvolutionDetail]]]?
    
    init(networkManager: Networking & JSONDecoding, species: PokemonSpecies) {
        self.networkManager = networkManager
        self.species = species
        
        Task {
            await getEvolutionChain()
        }
    }
    
    @MainActor
    func getEvolutionChain() async {
        do {
            let url = species.evolutionChain.url
            print(url)
            
            let data = try await networkManager.request(endpoint: ApiResponseEndpoint.resource(baseURL: url, path: nil))
            
            let evolutionChain = try await networkManager.decode(data: data, modelType: EvolutionChain.self)
            print(evolutionChain)
            
            self.evolutionChain = evolutionChain
            
        } catch {
            print("PokemonEvolutionsVM - getEvolutionChain: \(error.localizedDescription)")
        }
    }
    
    func getNextChainLink(link: ChainLink) {
        for evolution in link.evolvesTo {
            evolutionChainDict?[link.species.name] = [evolution.species.name: evolution.evolutionDetails]
        }
        
        while !link.evolvesTo.isEmpty {
            
        }
    }
}

