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
            PokedexNoViewComponent(regionalDexNo: vm.pokemonEntry.entryNumber, nationalDexNo: vm.pokemon?.id ?? NumberConstants.zeroPlaeholder)
            
            
            HStack {
                // MARK: Name
                Text("\(vm.pokemon?.name.capitalized.replacingOccurrences(of: StringConstants.hyphen, with: StringConstants.space) ?? StringConstants.emptyString)")
                    .font(.largeTitle).bold()
                
                if let cry = vm.latestCry {
                    Button {
                        cry.play()
                    } label: {
                        Image(systemName: PokedexConstants.audioButtonIcon)
                            .imageScale(.large)
                    }
                }
            }
            
            // MARK: Types
            TypesViewComponent(vm: vm, types: vm.pokemon?.types ?? [])
            
            
            // MARK: Game Version Picker
            if vm.games.count > 1 {
                Picker(PokedexConstants.gameVersionPickerStringKey, selection: $vm.selectedversion) {
                    ForEach(vm.games, id: \.self) {
                        Text($0.replacingOccurrences(of: StringConstants.hyphen, with: StringConstants.space).capitalized).tag($0)
                    }
                }
                .padding(.top, NumberConstants.topContentPadding)
            }
            
            // MARK: Flavor Text
            Text(vm.getFlavorText())
                .padding(.horizontal, NumberConstants.horizontalContentPadding)
                .padding(.top, NumberConstants.topContentPadding)
            
            Divider()
                .padding(.vertical, NumberConstants.verticalContentPadding)
                .padding(.horizontal, NumberConstants.horizontalContentPadding)
            
            VStack(alignment: .leading, spacing: PokedexConstants.detailsViewComponentContentSpacing) {
                
                // MARK: Abilities
                AbilitiesViewComponent(pokemonAbilities: vm.pokemon?.abilities ?? [], abilities: vm.abilities, accentColor: type1Color, versions: vm.settings.game.versions)
                
                
                // MARK: Stats
                StatsViewComponent(accentColor: type1Color, stats: vm.pokemon?.stats ?? [])
                
                
                // MARK: Resistances
                ResistancesViewComponent(vm: vm)
                
                
                // MARK: Weaknesses
                WeaknessesViewComponent(vm: vm)
                
                
                // MARK: Characteristics
                CharacteristicsViewComponent(accentColor: type1Color, name: vm.pokemon?.name.capitalized ?? StringConstants.notAvailable, height: vm.getHeightWeight(vm.pokemon?.height ?? NumberConstants.zeroPlaeholder, isHeight: true), weight: vm.getHeightWeight(vm.pokemon?.weight ?? NumberConstants.zeroPlaeholder, isHeight: false), captureRate: vm.species?.captureRate ?? NumberConstants.zeroPlaeholder, firstAppearance: vm.species?.generation.name ?? StringConstants.notAvailable, eggGroups: vm.species?.eggGroups ?? [], hatchCounter: vm.species?.hatchCounter ?? NumberConstants.zeroPlaeholder, genderRate: vm.species?.genderRate ?? PokedexConstants.genderRatePlaceholder, growthRate: vm.species?.growthRate.name.replacingOccurrences(of: StringConstants.hyphen, with: StringConstants.space).capitalized.replacingOccurrences(of: "Then", with: "then") ?? StringConstants.notAvailable, baseExpYield: vm.pokemon?.baseExperience ?? NumberConstants.zeroPlaeholder, category: vm.species?.genera.filter({$0.language.name == LanguageCode.english.rawValue}).first?.genus ?? StringConstants.notAvailable, stats: vm.pokemon?.stats.filter({$0.effort > 0}) ?? [], isLegendary: vm.species?.isLegendary ?? false, isMythical: vm.species?.isMythical ?? false, isBaby: vm.species?.isBaby ?? false)

            }
            .padding(.horizontal, NumberConstants.horizontalContentPadding)
            
            


            Spacer()
        }
    }
    
    
    
}

#Preview {
    MainView()
        .environmentObject(Coordinator(settings: Settings()))
}
