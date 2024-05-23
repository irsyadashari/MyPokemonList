//
//  MyPokemonListPresenterImpl.swift
//  MyPokemonList
//
//  Created by Irsyad Ashari on 22/05/24.
//

import Foundation
import UIKit
import CoreData

class MyPokemonListPresenterImpl: MyPokemonListPresenter {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var myPokemonsEntity: [PokemonDetailEntity]?
    
    var myPokemons: [PokemonDetail]? {
        myPokemonsEntity?.toPokemonDetail()
    }
    
    weak var delegate: MyPokemonListPresenterDelegate?
    
    func viewDidLoad() {
        loadItems()
    }
    
    func loadItems() { //TODO: Improvements, these can be made to ONLY loaded from DB when there is a change on DB or the current cache is empty
        let request = PokemonDetailEntity.fetchRequest()
        do {
            myPokemonsEntity = try context.fetch(request)
            delegate?.refreshTableView()
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    func getMyPokemonItem(at index: Int) -> PokemonDetail? {
        guard let myPokemons, index < myPokemons.count else { return nil }
        return myPokemons[index]
    }
    
    private func saveDB() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    func renamePokemon(pokemonDetail: PokemonDetail, newName: String) {
        // When user finished entering new name, then save database
        guard !newName.isEmpty,
              let myPokemonsEntity,
                let index = myPokemonsEntity.firstIndex(where: {$0.name == pokemonDetail.name}),
              index < myPokemonsEntity.count else { return }
        
        myPokemonsEntity[index].setValue(newName, forKey: "nickName")
        self.myPokemonsEntity = myPokemonsEntity
        saveDB()
        
        // refresh data table view after DB Update
        delegate?.refreshTableView()
    }
    
    func releasePokemon(pokemonDetail: PokemonDetail) {
        // when user confirm deletion, then remove pokemon database
        guard var myPokemonsEntity, let index = myPokemonsEntity.firstIndex(where: {$0.name == pokemonDetail.name}),
              index < myPokemonsEntity.count else { return }
        
        context.delete(myPokemonsEntity[index])
        myPokemonsEntity.remove(at: index)
        self.myPokemonsEntity = myPokemonsEntity
        saveDB()
        
        // refresh data table view after DB Update
        delegate?.refreshTableView()
    }
}
