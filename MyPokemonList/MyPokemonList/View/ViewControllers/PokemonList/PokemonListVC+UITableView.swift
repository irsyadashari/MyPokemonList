//
//  PokemonListVC+UITableView.swift
//  MyPokemonList
//
//  Created by Irsyad Ashari on 22/05/24.
//

import UIKit

extension PokemonListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Item \(indexPath.row) is tapped")
    }
}

extension PokemonListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let itemCount = presenter?.pokemonPage?.pokemonsList.count else {
            return 0
        }
        return itemCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonCell.reuseIdentifier, for: indexPath) as? PokemonCell else {
            return UITableViewCell()
        }
        
        guard let presenter = self.presenter, let item = presenter.getPokemonItem(at: indexPath.row) else {
            return  UITableViewCell()
        }
        
        cell.configure(item: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

