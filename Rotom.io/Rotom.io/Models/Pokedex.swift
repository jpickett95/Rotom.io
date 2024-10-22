//
//  Pokedex.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 10/21/24.
//

struct CustomPokedex {
    let id: Int
    let name: String
    let pokemon: [PokedexPokemon]
}

struct PokedexPokemon {
    let name: String
    let spriteURL: String
}

/**
 - Parameters:
    - id: The identifier for this resource.
    - name: The name for this resource.
    - names: The name of this resource listed in different languages.
    - pokemonEntries: A list of Pokémon catalogued in this Pokédex and their indexes.
 */
struct Pokedex: Decodable {
    let id: Int
    let name: String
    let names: [Name]
    let pokemonEntries: [PokemonEntry]
}

/**
 - Parameters:
    - entryNumber: The index of this Pokémon species entry within the Pokédex.
    - pokemonSpecies: The Pokémon species being encountered.
 */
struct PokemonEntry: Decodable {
    let entryNumber: Int
    let pokemonSpecies: NamedApiResource
}

struct Pokemon: Decodable {
    let sprites: PokemonSprites
}

struct PokemonSprites: Decodable {
    let frontDefault: String
}

struct PokemonSpecies: Decodable {
    let id: Int
    let name: String
}
