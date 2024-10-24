//
//  PokedexDetailsTabView.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 10/22/24.
//

import SwiftUI

struct PokemonDetailsTabView: View {
    // MARK: Body
    var body: some View {
        CustomNavigationStack {
            Text("\("Bulbasaur")")
        } contentView: {
            TabView {
                
                // MARK: Details
                Tab("Details", systemImage: "list.bullet", role: .none) {
                    PokemonDetailsView()
                }
                
                // MARK: Evolutions
                Tab("Evolutions", systemImage: "point.3.connected.trianglepath.dotted", role: .none) {
                    PokemonEvolutionsView()
                }
                
                // MARK: Locations
                Tab("Locations", systemImage: "location.north", role: .none) {
                    PokemonLocationsView()
                }
                
                // MARK: Moves
                Tab("Moves", systemImage: "dot.scope", role: .none) {
                    PokemonMovesView()
                }

            }
            .tint(.typeUnknown) // Pokemon Type Color
        }
    }
}

#Preview {
    MainView()
        .environmentObject(Coordinator(settings: Settings()))
}
