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
    @EnvironmentObject var coordinator: Coordinator
    @State var selectedGame: Game? = Game.national

    // MARK: Body
    var body: some View {
        NavigationStack {
            
            ScrollView {
                Text(coordinator.settings.game.name)
                
                // MARK: Pokedex
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
                }
            }
            
        }
    }
}

// MARK: Preview
#Preview {
    MainView()
        .environmentObject(Coordinator(settings: Settings()))
}
