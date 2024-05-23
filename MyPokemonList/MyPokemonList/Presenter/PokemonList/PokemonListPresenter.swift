//
//  PokemonListPresenter.swift
//  MyPokemonList
//
//  Created by Irsyad Ashari on 22/05/24.
//

import Foundation

protocol PokemonListPresenterDelegate: NSObjectProtocol {
    func didDataLoaded()
}

protocol PokemonListPresenter {
    var pokemonPage: PokemonPage? { get }
    var delegate: PokemonListPresenterDelegate? { get set }
    
    func viewDidLoad()
    func getPokemonItem(at index: Int) -> PokemonItem?
}
