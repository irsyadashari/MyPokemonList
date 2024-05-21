//
//  PokemonCell.swift
//  MyPokemonList
//
//  Created by Irsyad Ashari on 21/05/24.
//

import UIKit

final class PokemonCell: UITableViewCell {
    private lazy var containerView = UIView().parent(contentView)
    private lazy var iconView = UIImageView().parent(containerView)
    private lazy var nameLabel = UILabel().parent(containerView)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        nameLabel.textAlignment = .left
        iconView.contentMode = .scaleAspectFill
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(item: PokemonItem) {
        nameLabel.text = item.pokemonName
        loadImage(pokemonName: item.pokemonName)
    }
    
    private func loadImage(pokemonName: String) {
        let queue = DispatchQueue(label: "load-image", qos: .userInteractive, attributes: .concurrent)
        
        queue.async {
            let endpoint = PokemonAPI.getPokemonDetails(name: pokemonName)
            NetworkManager.request(endpoint: endpoint) { [weak self] (result: Result<PokemonDetailResponse, Error>) in
                switch result {
                case .success(let response):
                    let imageURL = response.sprites.frontImage
                    DispatchQueue.main.async {
                        self?.iconView.loadImageFromURL(urlString: imageURL)
                    }
                case .failure(let error):
                    print("error: \(error)")
                }
            }
        }
    }
    
    private func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        iconView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 16).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 16).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: iconView.centerYAnchor).isActive = true
    }
}
