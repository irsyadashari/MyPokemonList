//
//  MyPokemonsList.swift
//  MyPokemonList
//
//  Created by Irsyad Ashari on 22/05/24.
//

import Foundation
import UIKit
import CoreData

// This page is to show catched pokemon
final class MyPokemonsListVC: UIViewController {
    private lazy var tableView = UITableView().parent(self.view)
    private lazy var emptyLabel = UILabel().parent(self.view)
    
    var presenter: MyPokemonListPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.delegate = self
        presenter?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
        presenter?.loadItems() //TODO: Improvement, this line should only be executed when there is a change in DB values
    }
    
    private func setupView() {
        view.backgroundColor = .white
        title = "My Pokemon Deck"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        emptyLabel.textAlignment = .center
        emptyLabel.fillSuperView(to: view)
        emptyLabel.text = "No Pokemon catched yet"
    
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.fillSuperView(to: view, distance: 16)
        tableView.register(MyPokemonCell.self, forCellReuseIdentifier: MyPokemonCell.reuseIdentifier)
    }
    
    func goToDetailPage(detail: PokemonDetail) {
        let detailPage = PokemonDetailVC()
        let presenter = PokemonDetailPresenterImpl()
        presenter.pokemonDetail = detail
        detailPage.presenter = presenter
        detailPage.title = "Detail Page"
        navigationController?.pushViewController(detailPage, animated: true)
    }
}

extension MyPokemonsListVC: MyPokemonListPresenterDelegate {
    func refreshTableView() {
        DispatchQueue.main.async {
            print("reload table")
            let isDataExist: Bool = (self.presenter?.myPokemonsEntity?.count ?? 0 > 0)
            self.tableView.isHidden = !isDataExist
            self.emptyLabel.isHidden = isDataExist
            self.tableView.reloadData()
        }
    }
}

extension MyPokemonsListVC: MyPokemonCellDelegate {
    func didTapReleasePokemon(pokemonDetail: PokemonDetail) {
        // Open alert button with warning to delete pockemon from DB
        let alertController = UIAlertController(title: "Remove Pokemon", message: "Are you sure ?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let submitAction = UIAlertAction(title: "Submit", style: .default) { (action) in
            self.presenter?.releasePokemon(pokemonDetail: pokemonDetail)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(submitAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func didTapRenamePokemon(pokemonDetail: PokemonDetail) {
        //Open alert button with textfield to edit nickname
        let alertController = UIAlertController(title: "Rename Pokemon", message: "Aqiqah your pokemon ?", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            if let pokemonNickName = pokemonDetail.pokemonNickName {
                textField.text = pokemonDetail.pokemonNickName
            } else {
                textField.text = pokemonDetail.name
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let submitAction = UIAlertAction(title: "Submit", style: .default) { (action) in
            if let textField = alertController.textFields?.first, let newName = textField.text {
                self.presenter?.renamePokemon(pokemonDetail: pokemonDetail, newName: newName)
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(submitAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
