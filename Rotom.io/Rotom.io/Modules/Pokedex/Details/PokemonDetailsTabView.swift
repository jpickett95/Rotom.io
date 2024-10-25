//
//  PokedexDetailsTabView.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 10/22/24.
//

import SwiftUI

struct PokemonDetailsTabView: View {
    
    // MARK: Properties
    @ObservedObject private var vm: PokemonDetailsViewModel
    
    // MARK: Lifecycle
    init(viewModel: PokemonDetailsViewModel) {
        self.vm = viewModel
    }
    
    // MARK: Body
    var body: some View {
        CustomNavigationStack {
            HStack(spacing: 10) {
                if let imageData = FileManager.readDataFromFile(filename: "\(vm.pokemonEntry.pokemonSpecies.name).dat"), let image = UIImage(data: imageData) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }
                
                Text("\(vm.pokemonEntry.pokemonSpecies.name.capitalized)")
            }
        } contentView: {
            TabView {
                
                // MARK: Details
                Tab("Details", systemImage: "list.bullet", role: .none) {
                    PokemonDetailsView(viewModel: vm)
                }
                
                // MARK: Evolutions
                Tab("Evolutions", systemImage: "point.3.connected.trianglepath.dotted", role: .none) {
                    PokemonEvolutionsView()
                }
                
                // MARK: Locations
                Tab("Locations", systemImage: "location.north", role: .none) {
                    PokemonLocationsView()
                }
                
                // MARK: Moves
                Tab("Moves", systemImage: "dot.scope", role: .none) {
                    PokemonMovesView()
                }

            }
            .tint(.typeUnknown) // Pokemon Type Color
        }
    }
}

#Preview {
    MainView()
        .environmentObject(Coordinator(settings: Settings()))
}
