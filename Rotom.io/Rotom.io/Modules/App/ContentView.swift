//
//  ContentView.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 10/14/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: Properties
    @EnvironmentObject var settings: Settings
    @EnvironmentObject var coordinator: Coordinator
    @State var selectedGame: Game? = Game.national

    // MARK: Body
    var body: some View {
        NavigationStack {
            
            ScrollView {
                Text(settings.game.name)
                
                // MARK: Pokedex
//                NavigationLink(destination: {
//                    CustomNavigationStack {
//                        Text("Pokedex")
//                    } contentView: {
//                        PokedexView(viewModel: PokedexViewModel(networkManager: NetworkManager(), settings: settings))
//                    }
//                }, label: {
//                    Text("Pokedex")
//                })
                Button {
                    coordinator.navigateToPokedex()
                } label: {
                    Text("Pokedex")
                }

            }
            //.navigationTitle("Rotom.io")
            //.navigationBarTitleDisplayMode(.large)
            .toolbar {
                // MARK: Navigation Title
                ToolbarItem(placement: .topBarLeading) {
                    Text("Rotom.io")
                        .font(.title).bold()
                }
                
                // MARK: Selected Game
                ToolbarItem(placement: .topBarTrailing) {
                    
                    Button {
                        //showingSheet.toggle()
                        coordinator.showGameSelection()
                    } label: {
                        Image(systemName: "circle")
                    }
//                    .sheet(isPresented: $showingSheet) {
//                        GameSheetView()
//                    }
                }
                
                
                
            }
            
        }
    }
}

// MARK: Preview
#Preview {
    MainView()
        .environmentObject(Settings())
        .environmentObject(Coordinator())
}
