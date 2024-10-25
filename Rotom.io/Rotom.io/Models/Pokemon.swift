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
