//
//  PokemonDetailResponse.swift
//  MyPokemonList
//
//  Created by Irsyad Ashari on 22/05/24.
//

import Foundation

struct PokemonDetailResponse: Decodable {
    let name: String
    let sprites: PokemonImageResponse
    let abilities: [PokemonAbilitiesResponse]
    let moves: [PokemonMovesResponse]
    let types: [PokemonTypesResponse]
}

extension PokemonDetailResponse {
    func toDomainModel() -> PokemonDetail {
        let abilities: String = abilities.map {
            $0.ability.name.capitalized
        }.joined(separator: ", ")
        
        let moves: String = moves.map {
            $0.move.name.capitalized
        }.joined(separator: ", ")
        
        let types: String = types.map {
            $0.type.name.capitalized
        }.joined(separator: ", ")
        
        return PokemonDetail(
            name: name, 
            pokemonNickName: nil,
            urlImages: sprites.toPokemonImageURLS(),
            abilities: abilities,
            types: types,
            moves: moves
        )
    }
}

struct PokemonTypesResponse: Decodable {
    let slot: Int
    let type: PokemonItemType
}

struct PokemonItemType: Decodable {
    let name: String
    let url: String
}

struct PokemonMovesResponse: Decodable {
    let move: ItemMovesResponse
}

struct ItemMovesResponse: Decodable {
    let name: String
    let url: String
}

struct PokemonImageResponse: Decodable {
    let frontImage: String
    let backImage: String
    
    enum CodingKeys: String, CodingKey {
        case frontImage = "front_default"
        case backImage = "back_default"
    }
}

extension PokemonImageResponse {
    func toPokemonImageURLS() -> PokemonImageURLS {
        return PokemonImageURLS(frontImage: frontImage, backImage: backImage)
    }
}

struct PokemonAbilitiesResponse: Decodable {
    let ability: AbilityResponse
    let slot: Int
}

struct AbilityResponse: Decodable {
    let name: String
    let url: String
}
