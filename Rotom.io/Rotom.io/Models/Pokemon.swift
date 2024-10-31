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

struct SpeciesType: Decodable {
    let slot: Int
    let type: NamedApiResource
}

struct PokemonSpecies: Decodable {
    let flavorTextEntries: [FlavorText]
    let varieties: [PokemonSpeciesVariety]
}

struct PokemonSpeciesVariety: Decodable {
    let isDefault: Bool
    let pokemon: NamedApiResource
}

struct PokemonStat: Decodable {
    let stat: NamedApiResource
    let effort: Int
    let baseStat: Int
}
