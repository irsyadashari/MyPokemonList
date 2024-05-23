//
//  MyPokemonCell.swift
//  MyPokemonList
//
//  Created by Irsyad Ashari on 22/05/24.
//

import UIKit

protocol MyPokemonCellDelegate: NSObjectProtocol {
    func didTapReleasePokemon(pokemonDetail: PokemonDetail)
    func didTapRenamePokemon(pokemonDetail: PokemonDetail)
}

final class MyPokemonCell: UITableViewCell {
    private lazy var iconView = UIImageView().parent(contentView)
    private lazy var nickNameLabel = UILabel().parent(contentView)
    private lazy var originalNameLabel = UILabel().parent(contentView)
    private lazy var deleteBtn = UIButton().parent(contentView)
    private lazy var renameBtn = UIButton().parent(contentView)
    
    var pokemonDetail: PokemonDetail?
    weak var delegate: MyPokemonCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        nickNameLabel.textAlignment = .left
        nickNameLabel.numberOfLines = 1
        nickNameLabel.font = UIFont.systemFont(ofSize: 18)
        originalNameLabel.font = UIFont.systemFont(ofSize: 12)
        
        iconView.contentMode = .scaleAspectFill
        
        deleteBtn.setTitle("Release", for: .normal)
        deleteBtn.setTitleColor(.white, for: .normal)
        deleteBtn.backgroundColor = .red
        
        // Handle btn release tap
        let tapReleaseBtn = UITapGestureRecognizer(target: self, action: #selector(self.onRemoveBtnTapped(_:)))
        deleteBtn.addGestureRecognizer(tapReleaseBtn)
        deleteBtn.titleEdgeInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
        
        renameBtn.setImage(UIImage(named: "ic-pencil"), for: .normal)
        
        // Handle btn rename tap
        let tapRenameBtn = UITapGestureRecognizer(target: self, action: #selector(self.onRenameBtnTapped(_:)))
        renameBtn.addGestureRecognizer(tapRenameBtn)
        renameBtn.isUserInteractionEnabled = true
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(item: PokemonDetail) {
        self.pokemonDetail = item
        
        if let pokemonNickName = item.pokemonNickName {
            nickNameLabel.text = pokemonNickName.capitalized
        } else {
            nickNameLabel.text = item.name
        }
        
        originalNameLabel.text = "Origin: \(item.name.capitalized)"
        
        iconView.loadImageFromURL(urlString: item.urlImages.frontImage)
    }
    
    @objc func onRemoveBtnTapped(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        if let pokemonDetail {
            delegate?.didTapReleasePokemon(pokemonDetail: pokemonDetail)
        }
    }
    
    @objc func onRenameBtnTapped(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        if let pokemonDetail {
            delegate?.didTapRenamePokemon(pokemonDetail: pokemonDetail)
        }
    }
    
    private func setupConstraints() {
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        iconView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        
        deleteBtn.translatesAutoresizingMaskIntoConstraints = false
        deleteBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32).isActive = true
        deleteBtn.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        deleteBtn.widthAnchor.constraint(equalToConstant: 90).isActive = true
        
        renameBtn.translatesAutoresizingMaskIntoConstraints = false
        renameBtn.trailingAnchor.constraint(equalTo: deleteBtn.leadingAnchor, constant: -16).isActive = true
        renameBtn.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        renameBtn.heightAnchor.constraint(equalToConstant: 16).isActive = true
        renameBtn.widthAnchor.constraint(equalToConstant: 16).isActive = true
        
        nickNameLabel.translatesAutoresizingMaskIntoConstraints = false
        nickNameLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 16).isActive = true
        nickNameLabel.trailingAnchor.constraint(equalTo: renameBtn.leadingAnchor, constant: -24).isActive = true
        nickNameLabel.centerYAnchor.constraint(equalTo: iconView.centerYAnchor).isActive = true
        
        originalNameLabel.translatesAutoresizingMaskIntoConstraints = false
        originalNameLabel.leadingAnchor.constraint(equalTo: nickNameLabel.leadingAnchor).isActive = true
        originalNameLabel.topAnchor.constraint(equalTo: nickNameLabel.bottomAnchor, constant: 4).isActive = true
        originalNameLabel.trailingAnchor.constraint(equalTo: renameBtn.leadingAnchor, constant: -24).isActive = true
        
    }
}
