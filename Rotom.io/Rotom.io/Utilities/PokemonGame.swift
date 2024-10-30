//
//  PokemonGame.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 10/21/24.
//

enum Game: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    
    case national
    
    // Place most recent game at this point. (Latest release first)
    case scarletViolet
    case legendsArceus
    case brilliantDiamondShiningPearl
    case swordShield
    case letsGo
    case ultraSunMoon
    case sunMoon
    case omegaRubyAlphaSapphire
    case xY
    case black2White2
    case blackWhite
    case soulSilverHeartGold
    case platinum
    case diamondPearl
    case fireRedLeafGreen
    case emerald
    case rubySapphire
    case Crystal
    case goldSilver
    case redBlueYellow
}

struct PokemonGame: Equatable {
    let name: String
    let pokedexIDs: [Int]
    let versions: [String]
}

extension PokemonGame {
    static func getGame(game: Game) -> PokemonGame {
        switch game {
        case .national:
            PokemonGame(name: "National", pokedexIDs: [1], versions: [String]())
        case .scarletViolet:
            PokemonGame(name: "Scarlet & Violet", pokedexIDs: [31, 32, 33], versions: ["scarlet", "violet", "the-teal-mask", "the-indigo-disk"])
        case .legendsArceus:
            PokemonGame(name: "Legends: Arceus", pokedexIDs: [30], versions: ["legends-arceus"])
        case .brilliantDiamondShiningPearl:
            PokemonGame(name: "Brilliant Diamond & Shining Pearl", pokedexIDs: [5], versions: ["shining-pearl", "brilliant-diamond"])
        case .swordShield:
            PokemonGame(name: "Sword & Shield", pokedexIDs: [27, 28, 29], versions: ["sword", "shield", "the-isle-of-armor", "the-crown-tundra"])
        case .letsGo:
            PokemonGame(name: "Let's Go Pikachu! & Let's Go Eevee!", pokedexIDs: [26], versions: ["lets-go-pikachu", "lets-go-eevee"])
        case .ultraSunMoon:
            PokemonGame(name: "Ultra Sun & Ultra Moon", pokedexIDs: [21, 22, 23, 24, 25], versions: ["ultra-sun", "ultra-moon"])
        case .sunMoon:
            PokemonGame(name: "Sun & Moon", pokedexIDs: [16, 17, 18, 19, 20], versions: ["sun", "moon"])
        case .omegaRubyAlphaSapphire:
            PokemonGame(name: "Omega Ruby & Alpha Sapphire", pokedexIDs: [15], versions: ["omega-ruby, alpha-sapphire"])
        case .xY:
            PokemonGame(name: "X & Y", pokedexIDs: [12, 13, 14], versions: ["x", "y"])
        case .black2White2:
            PokemonGame(name: "Black 2 & White 2", pokedexIDs: [9], versions: ["black-2", "white-2"])
        case .blackWhite:
            PokemonGame(name: "Black & White", pokedexIDs: [8], versions: ["black", "white"])
        case .soulSilverHeartGold:
            PokemonGame(name: "Heart Gold & Soul Silver", pokedexIDs: [7], versions: ["heartgold", "soulsilver"])
        case .platinum:
            PokemonGame(name: "Platinum", pokedexIDs: [6], versions: ["platinum"])
        case .diamondPearl:
            PokemonGame(name: "Diamond & Pearl", pokedexIDs: [5], versions: ["diamond", "pearl"])
        case .fireRedLeafGreen:
            PokemonGame(name: "Fire Red & Leaf Green", pokedexIDs: [2], versions: ["firered", "leafgreen"])
        case .emerald:
            PokemonGame(name: "Emerald", pokedexIDs: [4], versions: ["emerald"])
        case .rubySapphire:
            PokemonGame(name: "Ruby & Sapphire", pokedexIDs: [4], versions: ["ruby", "sapphire"])
        case .Crystal:
            PokemonGame(name: "Crystal", pokedexIDs: [3], versions: ["crystal"])
        case .goldSilver:
            PokemonGame(name: "Gold & Silver", pokedexIDs: [3], versions: ["gold", "silver"])
        case .redBlueYellow:
            PokemonGame(name: "Red, Blue, & Yellow", pokedexIDs: [2], versions: ["red", "blue", "yellow"])
        }
    }
}
