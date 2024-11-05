//
//  Evolution.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 11/4/24.
//

struct EvolutionChain: Decodable {
    let id: Int
    let babyTriggerItem: NamedApiResource?
    let chain: ChainLink
}

struct ChainLink: Decodable {
    let isBaby: Bool
    let species: NamedApiResource
    let evolutionDetails: [EvolutionDetail]
    let evolvesTo: [ChainLink]
}

struct EvolutionDetail: Decodable {
    let item: NamedApiResource?
    let trigger: NamedApiResource
    let gender: Int?
    let heldItem: NamedApiResource?
    let knownMove: NamedApiResource?
    let KnownMoveType: NamedApiResource?
    let location: NamedApiResource?
    let minLevel: Int?
    let minHappiness: Int?
    let minBeauty: Int?
    let minAffection: Int?
    let needsOverworldRain: Bool
    let partySpecies: NamedApiResource?
    let partyType: NamedApiResource?
    let relativePhysicalStats: Int?
    let timeOfDay: String
    let tradeSpecies: NamedApiResource?
    let turnUpsideDown: Bool
}

struct EvolutionTrigger: Decodable {
    let id: Int
    let name: String
    let names: [Name]
    let pokemonSpecies: [NamedApiResource]
}
