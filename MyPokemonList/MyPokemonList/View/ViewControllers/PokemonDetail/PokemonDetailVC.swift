//
//  PokemonDetailVC.swift
//  MyPokemonList
//
//  Created by Irsyad Ashari on 21/05/24.
//

import UIKit
import CoreData

final class PokemonDetailVC: UIViewController {
    private let imageSize: CGFloat = (UIScreen.main.bounds.width / 2) - 32
    
    private lazy var frontImageView = UIImageView().parent(view)
    private lazy var backImageView = UIImageView().parent(view)
    private lazy var nameLabel = UILabel().parent(view)
    private lazy var abilitiesTitleLabel = UILabel().parent(view)
    private lazy var abilitiesValueLabel = UILabel().parent(view)
    private lazy var movesTitleLabel = UILabel().parent(view)
    private lazy var movesValueLabel = UILabel().parent(view)
    private lazy var typesTitleLabel = UILabel().parent(view)
    private lazy var typesValueLabel = UILabel().parent(view)
    private lazy var catchButton = RoundButton(frame: CGRect(x: 0, y: 0, width: 120, height: 120)).parent(view)
    
    var presenter: PokemonDetailPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configure()
    }
    
    private func configure() {
        guard let detail = presenter?.pokemonDetail else { return }
        self.presenter?.pokemonDetail = detail
        
        frontImageView.loadImageFromURL(urlString: detail.urlImages.frontImage)
        backImageView.loadImageFromURL(urlString: detail.urlImages.backImage)
        nameLabel.text = detail.name.capitalized
        abilitiesValueLabel.text = detail.abilities
        movesValueLabel.text = detail.moves
        typesValueLabel.text = detail.types
    }
    
    private func setupView() {
        view.backgroundColor = .white
        frontImageView.contentMode = .scaleToFill
        backImageView.contentMode = .scaleToFill
        
        nameLabel.font = UIFont.systemFont(ofSize: 36)
        nameLabel.textAlignment = .center
        nameLabel.text = "Pokemon Name"
        
        abilitiesTitleLabel.text = "Abilities :"
        abilitiesValueLabel.text = "abilitiesValueLabel"
        abilitiesTitleLabel.textAlignment = .left
        abilitiesValueLabel.textAlignment = .left
        abilitiesValueLabel.numberOfLines = 0
        
        typesTitleLabel.text = "Types :"
        typesValueLabel.text = "typesValueLabel"
        typesValueLabel.numberOfLines = 0
        typesTitleLabel.textAlignment = .left
        typesValueLabel.textAlignment = .left
        
        movesTitleLabel.text = "Moves :"
        movesValueLabel.text = "movesValueLabel"
        movesValueLabel.numberOfLines = 3
        movesTitleLabel.textAlignment = .left
        movesValueLabel.textAlignment = .left
        
        catchButton.setTitle("CATCH!", for: .normal)
        catchButton.addTarget(self, action: #selector(catchButtonTapped), for: .touchUpInside)
        
        setupConstraint()
    }
    
    @objc func catchButtonTapped() {
        handleCatchButton()
    }
    
    private func handleCatchButton() {
        presenter?.didCatchButtonTapped { [weak self] catchingPokemon in
            switch catchingPokemon {
            case .captured(let pokemonDetail):
                self?.handlePokemonCatched(pokemonDetail: pokemonDetail)
            case .escaped:
                self?.handlePokemonEscaped()
            }
        }
    }
    
    private func handlePokemonCatched(pokemonDetail: PokemonDetail) {
        // Create popup to add nickname to the pokemon
        let alertController = UIAlertController(title: "Pokemon Catched!", message: "Why don't you give it a name ?", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.text = pokemonDetail.name
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let submitAction = UIAlertAction(title: "Submit", style: .default) { (action) in
            if let textField = alertController.textFields?.first, let text = textField.text {
                self.presenter?.saveToDB(nickName: text) { isSuccess in
                    if isSuccess {
                        self.navigationController?.popViewController(animated: true)
                    } else {
                        print("failed to save DB")
                    }
                }
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(submitAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func handlePokemonEscaped() {
        // Create popup to inform user that pokemon escaped
        let alertController = UIAlertController(title: "Pokemon Escaped!", message: "Why don't you Try Again :)", preferredStyle: .alert)
        
        let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        alertController.addAction(closeAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func setupConstraint() {
        frontImageView.translatesAutoresizingMaskIntoConstraints = false
        frontImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        frontImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        frontImageView.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        frontImageView.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        
        backImageView.translatesAutoresizingMaskIntoConstraints = false
        backImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        backImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        backImageView.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        backImageView.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: backImageView.bottomAnchor, constant: 16).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        abilitiesTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        abilitiesTitleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16).isActive = true
        abilitiesTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        abilitiesTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16).isActive = true
        
        abilitiesValueLabel.translatesAutoresizingMaskIntoConstraints = false
        abilitiesValueLabel.topAnchor.constraint(equalTo: abilitiesTitleLabel.bottomAnchor, constant: 8).isActive = true
        abilitiesValueLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        abilitiesValueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        movesTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        movesTitleLabel.topAnchor.constraint(equalTo: abilitiesValueLabel.bottomAnchor, constant: 32).isActive = true
        movesTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        movesTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16).isActive = true
        
        movesValueLabel.translatesAutoresizingMaskIntoConstraints = false
        movesValueLabel.topAnchor.constraint(equalTo: movesTitleLabel.bottomAnchor, constant: 8).isActive = true
        movesValueLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        movesValueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        typesTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        typesTitleLabel.topAnchor.constraint(equalTo: movesValueLabel.bottomAnchor, constant: 32).isActive = true
        typesTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        typesTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16).isActive = true
        
        typesValueLabel.translatesAutoresizingMaskIntoConstraints = false
        typesValueLabel.topAnchor.constraint(equalTo: typesTitleLabel.bottomAnchor, constant: 8).isActive = true
        typesValueLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        typesValueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        catchButton.translatesAutoresizingMaskIntoConstraints = false
        catchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        catchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        catchButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        catchButton.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }
}
