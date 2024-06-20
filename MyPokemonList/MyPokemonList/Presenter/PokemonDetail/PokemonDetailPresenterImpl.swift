//
//  PokemonDetailPresenterImpl.swift
//  MyPokemonList
//
//  Created by Irsyad Ashari on 22/05/24.
//

import Foundation
import UIKit

final class PokemonDetailPresenterImpl: PokemonDetailPresenter {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var pokemonDetail: PokemonDetail?
    
    //TODO: this logic bussiness should be on interactor when we decide to scale the app's capability
    func didCatchButtonTapped(completion: ((CatchingPokemon) -> Void)) {
        guard let pokemonDetail else { return }
        
        let random = Int.random(in: 0..<100)
        if random % 2 == 0 {
            completion(.captured(pokemonDetail: pokemonDetail))
        } else {
            completion(.escaped)
        }
    }
    
    func saveToDB(nickName: String, completion: ((Bool) -> Void)) {
        let pokemonEntity = PokemonDetailEntity(context: self.context)
        pokemonEntity.name = pokemonDetail?.name
        pokemonEntity.backURLImage = pokemonDetail?.urlImages.backImage
        pokemonEntity.frontURLImage = pokemonDetail?.urlImages.frontImage
        pokemonEntity.nickName = nickName.isEmpty ? pokemonDetail?.name : nickName
        pokemonEntity.abilities = pokemonDetail?.abilities
        
        do {
            try context.save()
            completion(true)
        } catch {
            completion(false)
            print("Error saving context \(error)")
        }
    }
}
