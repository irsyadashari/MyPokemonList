//
//  PokemonCell.swift
//  MyPokemonList
//
//  Created by Irsyad Ashari on 21/05/24.
//

import UIKit

protocol PokemonCellDelegate: NSObjectProtocol {
    func didTapCell(pokemonDetail: PokemonDetail)
}

final class PokemonCell: UITableViewCell {
    private lazy var iconView = UIImageView().parent(contentView)
    private lazy var nameLabel = UILabel().parent(contentView)
    
    var pokemonDetail: PokemonDetail?
    weak var delegate: PokemonCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.systemFont(ofSize: 18)
        
        iconView.contentMode = .scaleToFill
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        contentView.addGestureRecognizer(tap)
        contentView.isUserInteractionEnabled = true
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(item: PokemonItem) {
        nameLabel.text = item.pokemonName.capitalized
        loadImage(pokemonName: item.pokemonName)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        if let pokemonDetail {
            delegate?.didTapCell(pokemonDetail: pokemonDetail)
        }
    }
    
    private func loadImage(pokemonName: String) {
        let queue = DispatchQueue(
            label: "load-image",
            qos: .userInteractive,
            attributes: .concurrent
        )
        
        queue.async {
            let endpoint = PokemonAPI.getPokemonDetails(name: pokemonName)
            NetworkManager.shared.request(endpoint: endpoint) { [weak self] (result: Result<PokemonDetailResponse, Error>) in
                switch result {
                case .success(let response):
                    self?.pokemonDetail = response.toDomainModel()
                    let imageURL = response.sprites.frontImage
                    self?.iconView.loadImageFromURL(urlString: imageURL)
                    
                case .failure(let error):
                    print("error: \(error)")
                }
            }
        }
    }
    
    private func setupConstraints() {
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        iconView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 16).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: iconView.centerYAnchor).isActive = true
    }
}
