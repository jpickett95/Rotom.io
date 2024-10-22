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
                    Section {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))]) {
                            ForEach(pokedex.pokemon, id: \.self.name) { entry in
                                
                            
                                AsyncImage(url: URL(string: entry.spriteURL))
                                
                            
                                  
//                                AsyncImage(url: URL(string: entry.spriteURL)) { phase in
//                                        if let image = phase.image {
//                                            image.resizable()
//                                            image.scaledToFit()
//                                            // Displays the loaded image.
//                                        } else if phase.error != nil {
//                                                 Image("Pokeball") // Indicates an error, show default image
//                                        } else {
//                                                 // Acts as a placeholder.
//                                                 ProgressView().progressViewStyle(.circular)
//                                                 // Image("Mickey Mouse")
//                                        }
//                                    }
                            
                                
                                
                                

                            }
                        }
                        .padding()
                    } header: {
                        HStack {
                            Text(pokedex.name)
                                .font(.title3).bold()
                            
                            Spacer()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.ultraThinMaterial)
                    } footer: {
                        HStack {
                            Spacer()
                            Text("\(pokedex.pokemon.count) Pokemon")
                                .font(.subheadline).bold()
                            Spacer()
                        }
                        .padding(.bottom)
                    }
                    
                }
            }
        }
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
    ContentView()
        .environmentObject(Settings())
}
