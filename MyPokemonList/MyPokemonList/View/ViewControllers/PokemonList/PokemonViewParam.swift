//
//  PokemonViewParam.swift
//  MyPokemonList
//
//  Created by Irsyad Ashari on 22/05/24.
//

import Foundation

struct Pokemon { //TODO Move this to another file
    let name: String
    let detail: PokemonDetail
}

struct PokemonViewParam {
    let name: String
    let nickName: String
    let urlImages: PokemonImageURLS
    let abilityName: [PokemonAbilities]
    var isCatched: Bool = false
}
