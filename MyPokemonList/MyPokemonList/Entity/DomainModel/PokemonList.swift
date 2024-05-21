//
//  PokemonList.swift
//  MyPokemonList
//
//  Created by Irsyad Ashari on 22/05/24.
//

import Foundation

struct PokemonPage {
    let count: Int?
    let nextURL: String?
    let previousURL: String?
    let pokemonsList: [PokemonItem]
}

struct PokemonItem {
    let pokemonName: String
    let detailURL: String
}
