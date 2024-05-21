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
}

extension PokemonDetailResponse {
    func toDomainModel() -> PokemonDetail {
        return PokemonDetail(
            name: name, 
            urlImages: sprites.toPokemonImageURLS(),
            abilities: abilities.toPokemonAbilities()
        )
    }
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

extension Array where Element == PokemonAbilitiesResponse {
    func toPokemonAbilities() -> [PokemonAbilities] {
        return self.map { ability in
            PokemonAbilities(abilityName: ability.ability.name, slot: ability.slot)
        }
    }
}

struct AbilityResponse: Decodable {
    let name: String
    let url: String
}
