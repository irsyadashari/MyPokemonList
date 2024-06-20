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
    func getPokemonDetail() -> PokemonDetail?
    func didCatchButtonTapped(completion: ((CatchingPokemon) -> Void))
    func didTapCatchButton(nickName: String, completion: ((Bool) -> Void))
}
