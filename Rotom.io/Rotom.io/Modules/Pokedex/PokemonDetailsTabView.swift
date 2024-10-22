//
//  PokedexDetailsTabView.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 10/22/24.
//

import SwiftUI

struct PokemonDetailsTabView: View {
    var body: some View {
        CustomNavigationStack {
            Text("\("Bulbasaur")")
        } contentView: {
            TabView {
                
                Tab("Details", systemImage: "list.bullet", role: .none) {
                    
                }
                
                Tab("Evolutions", systemImage: "point.3.connected.trianglepath.dotted", role: .none) {
                    
                }
                
                Tab("Locations", systemImage: "location.north", role: .none) {
                    
                }
                
                Tab("Moves", systemImage: "dot.scope", role: .none) {
                    
                }

            }
            .tint(.typeUnknown)
        }
    }
}

#Preview {
    NavigationStack {
        PokemonDetailsTabView()
    }
}
