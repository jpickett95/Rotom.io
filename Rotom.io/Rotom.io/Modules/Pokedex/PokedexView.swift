//
//  PokedexView.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 10/16/24.
//

import SwiftUI

struct PokedexView: View {
    // MARK: Properties
    @ObservedObject private var vm: PokedexViewModel
    @EnvironmentObject var settings: Settings
    
    // MARK: Lifecycle
    init(viewModel: PokedexViewModel) {
        self.vm = viewModel
    }
    
    // MARK: Body
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, pinnedViews: .sectionHeaders) {
                
                ForEach(vm.pokedexes, id: \.self.id) { pokedex in
                    
                    // MARK: Pokedex Section
                    Section {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 50), spacing: 15)]) {
                            ForEach(pokedex.pokemonEntries, id: \.self.entryNumber) { entry in
                                
                                // MARK: Pokemon Sprite
                                if let imageData = vm.sprites[entry.pokemonSpecies.name], let image = UIImage(data: imageData) {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFit()
                                    
                                } else {
                                    ProgressView()
                                        .progressViewStyle(.circular)
                                }
                            }
                        }
                        .padding()
                    } header: {
                        HStack {
                            Text(pokedex.name.replacingOccurrences(of: "-", with: " ").capitalized)
                                .font(.title3).bold()
                            
                            Spacer()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.ultraThinMaterial)
                    } footer: {
                        HStack {
                            Spacer()
                            Text("\(pokedex.pokemonEntries.count) Pokemon")
                                .font(.subheadline).bold()
                            Spacer()
                        }
                        .padding(.bottom)
                    }
                }
            }
        }
        //.background(Color.primary)
        //        .alert("Pokedex Error!", isPresented: $vm.presentAlert, actions: {
        //            Button("OK", role: .cancel) {
        //                vm.presentAlert = false
        //            }
        //        }, message: {
        //            if let error = vm.error {
        //                Text(ErrorManager.getErrorMessage(error))
        //            }
        //        })
        //        .task {
        //            await vm.getPokedexes()
        //        }
        //        .onChange(of: settings.game) {
        //            Task {
        //                await vm.getPokedexes()
        //            }
        //        }
        
    }
}

// MARK: Preview
#Preview {
    MainView()
        .environmentObject(Settings())
        .environmentObject(Coordinator())
}
