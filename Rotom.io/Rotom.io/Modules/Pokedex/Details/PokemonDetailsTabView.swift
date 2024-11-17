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
        let type1Color = Color(vm.getTypeColor(vm.pokemon?.types.first?.type.name ?? StringConstants.emptyString).rawValue)
        let type2Color = Color(vm.getTypeColor(vm.pokemon?.types.last?.type.name ?? StringConstants.emptyString).rawValue)
        
        TabView {
            
            // MARK: Details
            Tab(PokedexConstants.detailsTabTitle, systemImage: PokedexConstants.detailsTabIcon, role: .none) {
                PokemonDetailsView(viewModel: vm, type1Color: type1Color, type2Color: type2Color)
                
            }
            
            
            // MARK: Evolutions
            Tab(PokedexConstants.evolutionsTabTitle, systemImage: PokedexConstants.evolutionsTabIcon, role: .none) {
                
                if let species = vm.species {
                    PokemonEvolutionsView(viewModel: PokemonEvolutionsViewModel(networkManager: NetworkManager(), species: species))
                }
                
            }
            
            // MARK: Locations
            Tab(PokedexConstants.locationsTabTitle, systemImage: PokedexConstants.locationsTabIcon, role: .none) {
                PokemonLocationsView()
                
            }
            
            // MARK: Moves
            Tab(PokedexConstants.movesTabTitle, systemImage: PokedexConstants.movesTabIcon, role: .none) {
                PokemonMovesView()
                
            }
            
            
        }
        .background(RotomPhoneColors.background)
        .tint(type1Color) // Pokemon Type Color
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack(spacing: PokedexConstants.tabTopToolbarTitleSpacing) {
                    if let imageData = FileManager.readDataFromFile(filename: "\(vm.pokemonEntry.pokemonSpecies.name).dat"), let image = UIImage(data: imageData) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                    }
                    
                    Text("\(vm.pokemonEntry.pokemonSpecies.name.capitalized)")
                        .font(.headline).bold()
                        .foregroundStyle(.white)
                }
            }
        }
        .toolbarBackground(RotomPhoneColors.background, for: .navigationBar, .tabBar)
        .toolbarBackgroundVisibility(.visible, for: .navigationBar, .tabBar)
        
    }
}

#Preview {
    MainView()
        .environmentObject(Coordinator(settings: Settings()))
}
