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
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.fillSuperView(to: view, distance: 16)
        tableView.register(PokemonCell.self, forCellReuseIdentifier: PokemonCell.reuseIdentifier)
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

extension PokemonListVC: PokemonListPresenterDelegate {
    func didDataLoaded() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension PokemonListVC: PokemonCellDelegate {
    func didTapCell(pokemonDetail: PokemonDetail) {
        goToDetailPage(detail: pokemonDetail)
    }
}
