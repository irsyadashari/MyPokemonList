//
//  MyPokemonsListVC+UITableView.swift
//  MyPokemonList
//
//  Created by Irsyad Ashari on 22/05/24.
//

import UIKit

extension MyPokemonsListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let itemCount = presenter?.myPokemonsEntity?.count else {
            return 0
        }
        return itemCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPokemonCell.reuseIdentifier, for: indexPath) as? MyPokemonCell else {
            return UITableViewCell()
        }
        
        guard let presenter = self.presenter, let item = presenter.getMyPokemonItem(at: indexPath.row) else {
            return  UITableViewCell()
        }
        
        cell.configure(item: item)
        cell.delegate = self
        return cell
    }
}
