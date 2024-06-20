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
        
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.fillSuperView(to: view)
        tableView.register(PokemonCell.self, forCellReuseIdentifier: PokemonCell.reuseIdentifier)
    }
    
    private func goToDetailPage(detail: PokemonDetail) {
        let detailPage = PokemonDetailVC()
        let interactor = PokemonDetailInteractorImpl()
        interactor.pokemonDetail = detail
        let presenter = PokemonDetailPresenterImpl(interactor: interactor)
        
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
