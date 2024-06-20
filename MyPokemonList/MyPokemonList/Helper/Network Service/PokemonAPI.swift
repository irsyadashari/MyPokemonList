//
//  PokemonAPI.swift
//  MyPokemonList
//
//  Created by Irsyad Ashari on 22/05/24.
//

import Foundation

enum PokemonAPI: API {
    case getPokemonList(Void)
    case getPokemonDetails(name: String)
    
    var scheme: HTTPScheme {
        return .https
    }
    
    var baseURL: String {
        return "pokeapi.co"
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getPokemonList:
            return [
                URLQueryItem(name: "limit", value: "20"),
                URLQueryItem(name: "offset", value: "20")
            ]
        default:
            return []
        }
    }
    
    var path: String {
        switch self {
        case .getPokemonList:
            return "/api/v2/pokemon"
        case .getPokemonDetails(let name):
            return "/api/v2/pokemon/\(name)"
        }
    }
    
    var headers: [String : String] {
        return [:]
    }
    
    var method: HTTPMethod {
        return .get
    }
}
