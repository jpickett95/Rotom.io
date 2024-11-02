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
            ArtworkViewComponent(showShinyArtwork: $vm.showShinyArtwork, shinyArtwork: vm.shinyArtwork, officialArtwork: vm.officialArtwork, type1Color: type1Color, type2Color: type2Color, isLegendary: vm.species?.isLegendary ?? false, isMythical: vm.species?.isMythical ?? false, isBaby: vm.species?.isBaby ?? false)
            
            
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
                
                // MARK: Abilities
                AbilitiesViewComponent(pokemonAbilities: vm.pokemon?.abilities ?? [], abilities: vm.abilities, accentColor: type1Color, versions: vm.settings.game.versions)
                
                
                // MARK: Stats
                StatsViewComponent(accentColor: type1Color, stats: vm.pokemon?.stats ?? [])
                
                
                // MARK: Resistances
                ResistancesViewComponent(vm: vm)
                
                
                // MARK: Weaknesses
                WeaknessesViewComponent(vm: vm)
                
                
                // MARK: Characteristics
                CharacteristicsViewComponent(accentColor: type1Color, name: vm.pokemon?.name.capitalized ?? "N/A", height: vm.getHeightWeight(vm.pokemon?.height ?? 0, isHeight: true), weight: vm.getHeightWeight(vm.pokemon?.weight ?? 0, isHeight: false), captureRate: vm.species?.captureRate ?? 0, firstAppearance: vm.species?.generation.name ?? "N/A", eggGroups: vm.species?.eggGroups ?? [], hatchCounter: vm.species?.hatchCounter ?? 0, genderRate: vm.species?.genderRate ?? -2, growthRate: vm.species?.growthRate.name.replacingOccurrences(of: "-", with: " ").capitalized.replacingOccurrences(of: "Then", with: "then") ?? "N/A", baseExpYield: vm.pokemon?.baseExperience ?? 0, category: vm.species?.genera.filter({$0.language.name == "en"}).first?.genus ?? "N/A", stats: vm.pokemon?.stats.filter({$0.effort > 0}) ?? [], isLegendary: vm.species?.isLegendary ?? false, isMythical: vm.species?.isMythical ?? false, isBaby: vm.species?.isBaby ?? false)

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
