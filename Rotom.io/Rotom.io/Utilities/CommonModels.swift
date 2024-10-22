//
//  ResourceList.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 10/17/24.
//

/**
 - Parameters:
    - count: The total number of resources available from this API.
    - next: The URL for the next page in the list.
    - previous: The URL for the previous page in the list.
    - results: A list of named API resources.
 */
struct NamedApiResourceList: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [NamedApiResource]
}

/**
 - Parameters:
    - name: The name of the referenced resource.
    - url: The URL of the referenced resource.
 */
struct NamedApiResource: Decodable {
    let name: String
    let url: String
}

/**
 - Parameters:
    - count: The total number of resources available from this API
    - next: The URL for the next page in the list.
    - previous: The URL for the previous page in the list.
    - results: A list of unnamed API resources.
 */
struct ApiResourceList: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [ApiResource]
}

/**
 - Parameters:
    - url: The URL of the referenced resource.
 */
struct ApiResource: Decodable {
    let url: String
}

/**
 - Parameters:
    - name: The localized name for an API resource in a specific language.
    - language: The language this name is in.
 */
struct Name: Decodable {
    let name: String
    let language: NamedApiResource
}
