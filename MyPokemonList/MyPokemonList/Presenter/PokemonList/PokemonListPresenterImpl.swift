//
//  PokemonPresenterImpl.swift
//  MyPokemonList
//
//  Created by Irsyad Ashari on 22/05/24.
//

import Foundation

final class PokemonListPresenterImpl: PokemonListPresenter {
    var pokemonPage: PokemonPage? //TODO: Improvements: this should be in interactor
    weak var delegate: PokemonListPresenterDelegate?
    
    func viewDidLoad() {
        loadPokemonList()
    }
    
    func getPokemonItem(at index: Int) -> PokemonItem? {
        guard let page = pokemonPage else { return nil }
        return page.pokemonsList[index]
    }
    
    private func loadPokemonList() {
        let endpoint = PokemonAPI.getPokemonList(())
        NetworkManager.shared.request(endpoint: endpoint) { [weak self] (result: Result<PokemonListResponse, Error>) in
            switch result {
            case .success(let response):
                self?.pokemonPage = response.toModel()
                self?.delegate?.didDataLoaded()
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
}
