//
//  PokemonDetail.swift
//  MyPokemonList
//
//  Created by Irsyad Ashari on 22/05/24.
//

import Foundation

struct PokemonDetail {
    let name: String
    let urlImages: PokemonImageURLS
    let abilities: [PokemonAbilities]
}

struct PokemonImageURLS {
    let frontImage: String
    let backImage: String
}

struct PokemonAbilities {
    let abilityName: String
    let slot: Int
}
