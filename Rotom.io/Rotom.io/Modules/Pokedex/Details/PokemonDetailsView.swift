//
//  PokemonDetailsView.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 10/22/24.
//

import SwiftUI

struct PokemonDetailsView: View {
    @EnvironmentObject var coordinator: Coordinator
    @ObservedObject private var vm: PokemonDetailsViewModel
    let type1Color: Color
    let type2Color: Color
    
    init(viewModel: PokemonDetailsViewModel, type1Color: Color, type2Color: Color) {
        self.vm = viewModel
        self.type1Color = type1Color
        self.type2Color = type2Color
    }
    
    var body: some View {
        ScrollView {
            
            // MARK: Artwork
            ArtworkViewComponent(showShinyArtwork: $vm.showShinyArtwork, shinyArtwork: vm.shinyArtwork, officialArtwork: vm.officialArtwork, type1Color: type1Color, type2Color: type2Color)
            
            
            // MARK: Pokedex #
            PokedexNoViewComponent(regionalDexNo: vm.pokemonEntry.entryNumber, nationalDexNo: vm.pokemon?.id ?? 0)
            
            
            // MARK: Name
            Text("\(vm.pokemon?.name.capitalized ?? "")")
                .font(.largeTitle).bold()
            
            // MARK: Types
            TypesViewComponent(vm: vm, types: vm.pokemon?.types ?? [])
            
            
            // MARK: Game Version Picker
            if vm.games.count > 1 {
                Picker("Game Version", selection: $vm.selectedversion) {
                    ForEach(vm.games, id: \.self) {
                        Text($0.replacingOccurrences(of: "-", with: " ").capitalized).tag($0)
                    }
                }
                .padding(.top, 20)
            }
            
            // MARK: Flavor Text
            Text(vm.getFlavorText())
                .padding(.horizontal, 20)
                .padding(.top, 10)
            
            Divider()
                .padding(.vertical, 20)
                .padding(.horizontal, 20)
            
            VStack(alignment: .leading,spacing: 40) {
                
                // MARK: Stats
                StatsViewComponent(accentColor: type1Color, stats: vm.pokemon?.stats ?? [])
                
                
                // MARK: Resistances
                
                
                
                // MARK: Weaknesses
                
                
                
                // MARK: Characteristics
                CharacteristicsViewComponent(accentColor: type1Color, name: vm.pokemon?.name.capitalized ?? "", height: vm.getHeightWeight(vm.pokemon?.height ?? 0), weight: vm.getHeightWeight(vm.pokemon?.weight ?? 0))

            }
            .padding(.horizontal, 20)

            Spacer()
        }
    }
    
    
    
}

#Preview {
    MainView()
        .environmentObject(Coordinator(settings: Settings()))
}
