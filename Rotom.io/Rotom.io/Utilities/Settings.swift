//
//  Settings.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 10/16/24.
//

import Foundation

class Settings: ObservableObject {
    @Published var game: PokemonGame = PokemonGame.getGame(game: Game.national)
    @Published var pokemonIconSize = PokemonIconSize.medium
    
    enum PokemonIconSize {
        case small
        case medium
        case large
    }
    
}



