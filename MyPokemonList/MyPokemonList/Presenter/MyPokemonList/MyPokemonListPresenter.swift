//
//  MyPokemonListPresenter.swift
//  MyPokemonList
//
//  Created by Irsyad Ashari on 22/05/24.
//

import Foundation

protocol MyPokemonListPresenterDelegate: NSObjectProtocol {
    func refreshTableView()
}

protocol MyPokemonListPresenter {
    var myPokemonsEntity: [PokemonDetailEntity]? { get }
    var delegate: MyPokemonListPresenterDelegate? { get set }
    
    func viewDidLoad()
    func loadItems()
    func getMyPokemonItem(at index: Int) -> PokemonDetail?
    func renamePokemon(pokemonDetail: PokemonDetail, newName: String)
    func releasePokemon(pokemonDetail: PokemonDetail)
}
