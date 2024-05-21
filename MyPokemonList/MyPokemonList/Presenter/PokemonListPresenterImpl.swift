//
//  PokemonPresenterImpl.swift
//  MyPokemonList
//
//  Created by Irsyad Ashari on 22/05/24.
//

import Foundation

protocol PokemonListPresenterDelegate: NSObjectProtocol {
    func didDataLoaded()
}

final class PokemonListPresenterImpl: PokemonListPresenter {
    var pokemonPage: PokemonPage? // move this to interactor later
    var delegate: PokemonListPresenterDelegate?
    
    func viewDidLoad() {
        loadPokemonList()
    }
    
    func getPokemonItem(at index: Int) -> PokemonItem? {
        guard let page = pokemonPage else { return nil }
        
        return page.pokemonsList[index]
    }
    
    private func loadPokemonList() {
        let endpoint = PokemonAPI.getPokemonList(())
        NetworkManager.request(endpoint: endpoint) { [weak self] (result: Result<PokemonListResponse, Error>) in
            switch result {
            case .success(let response):
                self?.pokemonPage = response.toModel()
//                print("pokemonList: \(self?.pokemonPage)")
                self?.delegate?.didDataLoaded()
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
}
