//
//  PokemonDetail.swift
//  MyPokemonList
//
//  Created by Irsyad Ashari on 22/05/24.
//

import Foundation

struct PokemonDetail {
    let name: String
    let pokemonNickName: String?
    let urlImages: PokemonImageURLS
    let abilities: String
    let types: String
    let moves: String
}

extension Array where Element == PokemonDetailEntity {
    func toPokemonDetail() -> [PokemonDetail] {
        return self.map {
            let urlImages = PokemonImageURLS(
                frontImage: $0.frontURLImage ?? "",
                backImage: $0.backURLImage ?? "")
            let nickName = $0.nickName == nil ? $0.name : $0.nickName
            return PokemonDetail(
                name: $0.name ?? "", 
                pokemonNickName: nickName,
                urlImages: urlImages,
                abilities: $0.abilities ?? "",
                types: $0.types ?? "",
                moves: $0.moves ?? ""
            )
        }
    }
}

struct PokemonImageURLS {
    let frontImage: String
    let backImage: String
}
