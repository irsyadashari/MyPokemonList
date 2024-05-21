//
//  PokemonListResponse.swift
//  MyPokemonList
//
//  Created by Irsyad Ashari on 22/05/24.
//

import Foundation

struct PokemonListResponse: Decodable {
    let count: Int?
    let nextURL: String?
    let previousURL: String?
    let pokemonsList: [PokemonItemResponse]
    
    enum CodingKeys: String, CodingKey {
        case count
        case nextURL = "next"
        case previousURL = "previous"
        case pokemonsList = "results"
    }
}

extension PokemonListResponse {
    func toModel() -> PokemonPage {
        return PokemonPage(
            count: count,
            nextURL: nextURL,
            previousURL: previousURL,
            pokemonsList: pokemonsList.toPokemonItem()
        )
    }
}

struct PokemonItemResponse: Decodable {
    let pokemonName: String
    let detailURL: String
    
    enum CodingKeys: String, CodingKey {
        case pokemonName = "name"
        case detailURL = "url"
    }
}

extension Array where Element == PokemonItemResponse {
    func toPokemonItem() -> [PokemonItem] {
        return self.map {
            PokemonItem(pokemonName: $0.pokemonName, detailURL: $0.detailURL)
        }
    }
}
