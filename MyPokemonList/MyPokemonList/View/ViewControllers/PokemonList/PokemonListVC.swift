//
//  PokemonListVC.swift
//  MyPokemonList
//
//  Created by Irsyad Ashari on 22/05/24.
//

import UIKit
import Foundation

final class PokemonListVC: UIViewController {
    private lazy var tableView = UITableView().parent(self.view)
    var presenter: PokemonListPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.delegate = self
        presenter?.viewDidLoad()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        title = "Pokemon Lists"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.fillSuperView(to: view, distance: 16)
        
        registerCells()
    }
    
    private func registerCells() {
        tableView.register(PokemonCell.self, forCellReuseIdentifier: PokemonCell.reuseIdentifier)
    }
    
    private func goToDetailPage() {
        let detailPage = PokemonDetailVC()
        detailPage.view.backgroundColor = .red
        detailPage.title = "Detail Page"
        navigationController?.pushViewController(detailPage, animated: true)
    }
}

extension PokemonListVC: PokemonListPresenterDelegate {
    func didDataLoaded() {
        DispatchQueue.main.async {
            print("reload table")
            self.tableView.reloadData()
        }
    }
}
