//
//  GameSheetView.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 10/14/24.
//

import SwiftUI

struct GameSheetView: View {
    // MARK: Properties
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var coordinator: Coordinator
    
    // MARK: Body
    var body: some View {
        NavigationStack {
            List {
                ForEach(Game.allCases) { game in
                    Button {
                        coordinator.settings.game = PokemonGame.getGame(game: game)
                        dismiss()
                    } label: {
                        HStack(spacing: 20) {
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                            Text(PokemonGame.getGame(game: game).name)
                                .font(.headline)
                                .foregroundStyle(colorScheme == .light ? .black : .white)
                        }
                    }
                }.listRowBackground(
                    Capsule()
                        .fill(.tertiary)
                        .padding([.vertical, .horizontal], 5)
                )
            }
            .scrollIndicators(.hidden)
            .listRowSpacing(10)
            .background(.ultraThinMaterial)
            .navigationTitle("Choose a Game Version")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .foregroundStyle(.gray)
                    }
                }
            }
        }
    }
}

// MARK: Preview
#Preview {
    GameSheetView()
        .environmentObject(Coordinator(settings: Settings()))
}
