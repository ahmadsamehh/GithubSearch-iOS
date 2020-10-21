//
//  FavoriteCell.swift
//  GithubSearch
//
//  Created by Ahmad Sameh on 10/13/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    
    static let reuseID          = "FavCellReuseID"
    let loginNameLabel          = GSTitleLabel(textAllignment: .left, textSize: 25)
    let favoriteAvatarImageView = AvatarImageView(frame: .zero)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(favorite : Follower){
        loginNameLabel.text = favorite.login
        donwloadFavoriteImage(favorite: favorite)
    }
    
    
    func donwloadFavoriteImage(favorite : Follower){
        NetworkManager.shared.downloadImage(for: favorite.avatarUrl) { [weak self ](image) in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.favoriteAvatarImageView .image = image
                
            }
        }
    }
    
    
    private func configure(){
        let padding : CGFloat = 12
        accessoryType         = .disclosureIndicator
        
        addSubviews(favoriteAvatarImageView, loginNameLabel)
        
        NSLayoutConstraint.activate([
            favoriteAvatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            favoriteAvatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            favoriteAvatarImageView.heightAnchor.constraint(equalToConstant: 60),
            favoriteAvatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            loginNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            loginNameLabel.leadingAnchor.constraint(equalTo: favoriteAvatarImageView.trailingAnchor, constant: 24),
            loginNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            loginNameLabel.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
}
