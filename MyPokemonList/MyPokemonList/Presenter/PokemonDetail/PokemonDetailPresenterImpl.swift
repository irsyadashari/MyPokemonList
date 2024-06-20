//
//  PokemonDetailPresenterImpl.swift
//  MyPokemonList
//
//  Created by Irsyad Ashari on 22/05/24.
//

import Foundation
import UIKit

final class PokemonDetailPresenterImpl: PokemonDetailPresenter {
    var interactor: PokemonDetailInteractor
    
    init(interactor: PokemonDetailInteractor) {
        self.interactor = interactor
    }
    
    func getPokemonDetail() -> PokemonDetail? {
        return interactor.pokemonDetail
    }
    
    func didCatchButtonTapped(completion: ((CatchingPokemon) -> Void)) {
        interactor.isPokemonCatched(completion: completion)
    }
    
    func didPokemonSuccessfullyCaptured(nickName: String, completion: ((Bool) -> Void)) {
        interactor.saveToDB(nickName: nickName, completion: completion)
    }
}
