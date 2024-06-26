//
//  TabBarController.swift
//  MyPokemonList
//
//  Created by Irsyad Ashari on 22/05/24.
//

import Foundation
import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Create view controllers for each tab
        let pokemonListVC = PokemonListVC()
        pokemonListVC.tabBarItem = UITabBarItem(
            title: "Search",
            image: UIImage(systemName: "magnifyingglass"),
            selectedImage: nil)
        pokemonListVC.title = "Search"
        pokemonListVC.presenter = PokemonListPresenterImpl() //TODO: Improvement these could use dependency injection
        
        let myPokemonsListVC = MyPokemonsListVC()
        myPokemonsListVC.tabBarItem = UITabBarItem(
            title: "My Pokemons",
            image: UIImage(systemName: "star"),
            selectedImage: nil)
        myPokemonsListVC.title = "My Pokemons"
        myPokemonsListVC.presenter = MyPokemonListPresenterImpl()
        self.viewControllers = [pokemonListVC, myPokemonsListVC]
    }
}
