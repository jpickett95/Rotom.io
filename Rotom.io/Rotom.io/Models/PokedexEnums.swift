//
//  PokedexEnums.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 10/17/24.
//

enum VersionGroup: String, Decodable {
    case national = "National Dex"
    
    // Place most recent game at this point. (Latest release first)
    case scarletViolet = "scarlet-violet"
    case legendsArceus = "legends-arceus"
    case brilliantDiamondShiningPearl = "brilliant-diamond-and-shining-pearl"
    case swordShield = "sword-shield"
    case letsGo = "lets-go-pikachu-lets-go-eevee"
    case ultraSunMoon = "ultra-sun-ultra-moon"
    case sunMoon = "sun-moon"
    case omegaRubyAlphaSapphire = "omega-ruby-alpha-sapphire"
    case xY = "x-y"
    case black2White2 = "black-2-white-2"
    case blackWhite = "black-white"
    case soulSilverHeartGold = "heartgold-soulsilver"
    case platinum = "platinum"
    case diamondPearl = "diamond-pearl"
    case fireRedLeafGreen = "firered-leafgreen"
    case emerald = "emerald"
    case rubySapphire = "ruby-sapphire"
    case Crystal = "crystal"
    case goldSilver = "gold-silver"
    case redBlueYellow = "yellow"
}
