//
//  Type.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 11/2/24.
//

struct TypeData: Decodable {
    let id: Int
    let name: String
    let damageRelations: TypeRelations
}

struct TypeRelations: Decodable {
    let noDamageTo: [NamedApiResource]
    let noDamageFrom: [NamedApiResource]
    let halfDamageTo: [NamedApiResource]
    let halfDamageFrom: [NamedApiResource]
    let doubleDamageTo: [NamedApiResource]
    let doubleDamageFrom: [NamedApiResource]
}
