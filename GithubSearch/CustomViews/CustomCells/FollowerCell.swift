//
//  GSCell.swift
//  GithubSearch
//
//  Created by Ahmad Sameh on 10/1/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let reuseID    = "FollowerCell"
    let avatarImage       = AvatarImageView(frame: .zero)
    let usernameLabel     = GSTitleLabel(textAllignment: .center, textSize: 16)
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setInfo(follower: Follower){
        usernameLabel.text = follower.login
        downloadUserImage(follower: follower)
    }
    
    
    func downloadUserImage(follower : Follower){
        NetworkManager.shared.downloadImage(for: follower.avatarUrl) {[weak self] (image) in
            guard let self = self else {return}
            DispatchQueue.main.async {self.avatarImage.image = image}
        }
    }
    
    
    private func configure(){
        let padding : CGFloat = 8
        addSubviews(avatarImage,usernameLabel)
        
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarImage.widthAnchor.constraint(equalTo: avatarImage.heightAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 10),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImage.leadingAnchor, constant: 15),
            usernameLabel.trailingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
