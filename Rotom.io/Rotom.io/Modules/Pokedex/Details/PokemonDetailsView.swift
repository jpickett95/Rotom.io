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
    
    init(viewModel: PokemonDetailsViewModel) {
        self.vm = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // MARK: Artwork Picker
                Picker("Artwork", selection: $vm.showShinyArtwork) {
                    Text("Regular").tag(false)
                    Text("Shiny").tag(true)
                }
                .pickerStyle(.segmented)
                .padding(.vertical, 5)
                .frame(maxWidth: 150)
                
                // MARK: Artwork Image
                VStack(alignment: .leading) {
                    if let imageData = vm.showShinyArtwork ? vm.shinyArtwork : vm.officialArtwork, let image = UIImage(data: imageData) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .padding(.vertical, 20)
                    } else {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .padding(.vertical, 30)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 250)
                .background(LinearGradient(colors: [Color(vm.getTypeColor(type: vm.types.first ?? "").rawValue),.white,Color(vm.getTypeColor(type: vm.types.last ?? "").rawValue)], startPoint: .topLeading, endPoint: .bottomTrailing))
                .border(Color("rotomPhone-background-orange"), width: 3)
            }
            .background(Color("rotomPhone-background-orange"))
            
            HStack {
                // MARK: Regional Dex #
                Text("Regional # \(vm.pokemonEntry.entryNumber)")
                    .foregroundStyle(.white)
                    .font(.headline).bold()
                    .padding([.leading, .trailing], 20)
                    .padding(.vertical, 5)
                    .background(Color("rotomPhone-background-orange"))
                    .clipShape(
                        .rect(
                            topLeadingRadius: 0,
                            bottomLeadingRadius: 0,
                            bottomTrailingRadius: 20,
                            topTrailingRadius: 20
                        )
                    )
                
                Spacer()
                
                // MARK: National Dex #
                Text("National # \(vm.pokemon?.id ?? 0)")
                    .foregroundStyle(.white)
                    .font(.headline).bold()
                    .padding([.leading, .trailing], 20)
                    .padding(.vertical, 5)
                    .background(Color("rotomPhone-background-orange"))
                    .clipShape(
                        .rect(
                            topLeadingRadius: 20,
                            bottomLeadingRadius: 20,
                            bottomTrailingRadius: 0,
                            topTrailingRadius: 0
                        )
                    )
            }
            .frame(maxWidth: .infinity)
            .offset(y: -25)
            
            // MARK: Name
            Text("\(vm.pokemon?.name.capitalized ?? "")")
                .font(.largeTitle).bold()
            
            // MARK: Types
            HStack(spacing: 15) {
                Spacer()
                ForEach(vm.pokemon?.types ?? [], id: \.self.slot) { type in
                    HStack(spacing: 5) {
                        Image("\(type.type.name.capitalized)_icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        
                        Text(type.type.name.capitalized)
                            .font(.subheadline).bold()
                            .foregroundStyle(.white)
                    }
                    .padding(.vertical, 5)
                    .padding([.leading, .trailing], 8)
                    .background(Color(vm.getTypeColor(type: type.type.name).rawValue))
                    .clipShape(.capsule)
                    
                }
                Spacer()
            }
            .frame(maxHeight:30)
            
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
            
            VStack(spacing: 20) {
                
                // MARK: Stats
                VStack(alignment: .leading) {
                    Text("Stats")
                        .font(.title2).bold()
                    
                    if let stats = vm.pokemon?.stats {
                        ForEach(stats, id: \.self.stat.name) { stat in
                            
                            HStack {
                                Text(getStatAbbreviation(stat.stat.name)).bold()
                                    .foregroundStyle(Color(vm.getTypeColor(type: vm.pokemon?.types.first?.type.name ?? "").rawValue))
                                    .frame(minWidth: 70, alignment: .leading)
                                Text("\(stat.baseStat)").bold()
                                    .frame(minWidth: 70, alignment: .leading)
                                ProgressView(value: Float(stat.baseStat), total: 255)
                            }
                            
                            
                        }
                        
                        HStack {
                            Text("TOT").bold()
                                .foregroundStyle(Color(vm.getTypeColor(type: vm.pokemon?.types.first?.type.name ?? "").rawValue))
                                .frame(minWidth: 70, alignment: .leading)
                            Text("\(vm.getTotalStats())").bold()
                                .frame(minWidth: 70, alignment: .leading)
                            ProgressView(value: Float(vm.getTotalStats()), total: 255*6)
                        }
                    }
                }
                
                // MARK: Resistances
                
                // MARK: Weaknesses
                
                // MARK: Characteristics
            }
            .padding(.horizontal, 20)

            Spacer()
        }
    }
    
    func getStatAbbreviation(_ stat: String) -> String {
        switch stat {
        case "hp":
            return "HP"
        case "attack":
            return "ATK"
        case "defense":
            return "DEF"
        case "special-attack":
            return "SpATK"
        case "special-defense":
            return "SpDEF"
        case "speed":
            return "SPD"
        default:
            return "N/A"
        }
    }
    
}

#Preview {
    MainView()
        .environmentObject(Coordinator(settings: Settings()))
}
