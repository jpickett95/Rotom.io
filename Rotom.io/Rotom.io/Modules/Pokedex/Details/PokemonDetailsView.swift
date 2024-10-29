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
            
            
            
            
            Spacer()
        }
    }
    
}

#Preview {
    MainView()
        .environmentObject(Coordinator(settings: Settings()))
}
