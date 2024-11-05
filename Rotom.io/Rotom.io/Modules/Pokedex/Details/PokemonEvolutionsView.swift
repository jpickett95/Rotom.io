//
//  PokemonEvolutionsView.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 10/22/24.
//

import SwiftUI

struct PokemonEvolutionsView: View {
    @ObservedObject private var vm: PokemonEvolutionsViewModel
    
    init(viewModel: PokemonEvolutionsViewModel) {
        self.vm = viewModel
    }
    
    var body: some View {
        Text("Evolutions")
        
        if let chain = vm.evolutionChain {
            if !chain.chain.evolvesTo.isEmpty {
                Text(chain.chain.species.name)
                
                ForEach(chain.chain.evolvesTo,id: \.self.species.name) { species in
                    Text(species.species.name)
                }
            } else {
                Text("This pokemon does not evolve.")
            }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(Coordinator(settings: Settings()))
}
