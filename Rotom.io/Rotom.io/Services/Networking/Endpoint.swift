//
//  Endpoint.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 10/16/24.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum Path: String {
    case pokedex = "pokedex/"
    case versionGroup = "version-group/"
    case pokemon = "pokemon/"
    case pokemonSpecies = "pokemon-species/"
    
    // Unnamed
    case characteristic = "characteristic/"
    case contestEffect = "contest-effect/"
    case evolutionChain = "evolution-chain/"
    case machine = "machine/"
    case superContestEffect = "super-contest-effect/"
}

protocol Endpoint {
    var baseURL: URL { get }
    var headers: [String: String] { get }
    var method: HTTPMethod { get }
    var parameters: [String: String] { get }
    var path: String { get }
}

extension Endpoint {
    var headers: [String: String] { return [:] }
    var method: HTTPMethod { return .get }
    var parameters: [String: String] { return [:] }

}

struct PokeAPIEndpoint: Endpoint {
    var baseURL: URL = .init(string: "https://pokeapi.co/api/v2/")!
    var parameters: [String: String] = [:]
    var path: String = ""
}

extension PokeAPIEndpoint {
    static func resourceList(path: Path, limit: Int?, offset: Int?) -> Self {
        var parameters: [String: String] = [:]
        if let limit { parameters["limit"] = String(limit) }
        if let offset { parameters["offset"] = String(offset) }
        return PokeAPIEndpoint(parameters: parameters, path: path.rawValue)
    }
    
    static func resource(path: Path, id: Int) -> Self {
        let path = "\(path.rawValue)\(id)"
        return PokeAPIEndpoint(path: path)
    }
    
    static func resource(path: Path, name: String) -> Self {
        let path = "\(path.rawValue)\(name)"
        return PokeAPIEndpoint(path: path)
    }
}

struct ApiResponseEndpoint: Endpoint {
    var baseURL: URL
    var path: String
    
    static func resource(baseURL: String, path: String?) -> Self {
        var pathString = ""
        if let path { pathString.append("/\(path)") }
        return ApiResponseEndpoint(baseURL: .init(string: baseURL)!, path: pathString)
    }
}
