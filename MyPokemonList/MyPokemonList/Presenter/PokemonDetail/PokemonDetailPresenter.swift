//
//  PokemonDetailPresenter.swift
//  MyPokemonList
//
//  Created by Irsyad Ashari on 22/05/24.
//

import Foundation

enum CatchingPokemon {
    case captured(pokemonDetail: PokemonDetail)
    case escaped
}

protocol PokemonDetailPresenter {
    var pokemonDetail: PokemonDetail? { get set }
    
    func didCatchButtonTapped(completion: ((CatchingPokemon) -> Void))
    func saveToDB(nickName: String, completion: ((Bool) -> Void))
}
