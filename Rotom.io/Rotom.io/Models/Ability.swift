//
//  Ability.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 11/1/24.
//

struct Ability: Decodable {
    let id: Int
    let name: String
    let generation: NamedApiResource
    let flavorTextEntries: [AbilityFlavorText]
    let names: [Name]
}

struct AbilityFlavorText: Decodable {
    let flavorText: String
    let language: NamedApiResource
    let versionGroup: NamedApiResource
}
