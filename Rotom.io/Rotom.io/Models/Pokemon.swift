//
//  Pokemon.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 10/24/24.
//

struct Pokemon: Decodable {
    let id: Int
    let name: String
    let sprites: PokemonSprites
    let species: NamedApiResource
    let types: [SpeciesType]
    let stats: [PokemonStat]
    let height: Int
    let weight: Int
    let baseExperience: Int
    let abilities: [PokemonAbility]
    let cries: Cries
}

struct PokemonSprites: Decodable {
    let frontDefault: String
    let other: OtherArtwork
    
}

struct OtherArtwork: Decodable {
    let officialArtwork: OfficialArtwork
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}


struct OfficialArtwork: Decodable {
    let frontDefault: String
    let frontShiny: String
}

struct PokemonStat: Decodable {
    let stat: NamedApiResource
    let effort: Int
    let baseStat: Int
}

struct PokemonAbility: Decodable {
    let isHidden: Bool
    let slot: Int
    let ability: NamedApiResource
}

struct SpeciesType: Decodable {
    let slot: Int
    let type: NamedApiResource
}

struct Cries: Decodable {
    let latest: String
    let legacy: String
}

struct PokemonSpecies: Decodable {
    let flavorTextEntries: [FlavorText]
    let varieties: [PokemonSpeciesVariety]
    let captureRate: Int
    let eggGroups: [NamedApiResource]
    let hatchCounter: Int
    let growthRate: NamedApiResource
    let genderRate: Int
    let generation: NamedApiResource
    let genera: [Genus]
    let isLegendary: Bool
    let isMythical: Bool
    let isBaby: Bool
}

struct PokemonSpeciesVariety: Decodable {
    let isDefault: Bool
    let pokemon: NamedApiResource
}

struct Genus: Decodable {
    let genus: String
    let language: NamedApiResource
}
