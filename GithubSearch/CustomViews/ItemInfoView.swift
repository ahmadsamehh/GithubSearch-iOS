//
//  ItemInfoView.swift
//  GithubSearch
//
//  Created by Ahmad Sameh on 10/9/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.
//

import UIKit
enum itemInfoType {
    case following, followers, gists, publicRepos
}
class ItemInfoView: UIView {

    let itemImageView   = UIImageView()
    let itemTitleLabel  = GSTitleLabel(textAllignment: .left, textSize: 14)
    let itemNumberLabel = GSTitleLabel(textAllignment: .center, textSize: 14)
    var items :[UIView] = []
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    func configure(){
        
        addSubviews(itemImageView, itemTitleLabel,itemNumberLabel)
        
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.tintColor = .label
        itemImageView.contentMode = .scaleAspectFill
        itemNumberLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            itemImageView.topAnchor.constraint(equalTo: self.topAnchor),
            itemImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            itemImageView.widthAnchor.constraint(equalToConstant: 20),
            itemImageView.heightAnchor.constraint(equalToConstant: 20),
            
            
            itemTitleLabel.centerYAnchor.constraint(equalTo: itemImageView.centerYAnchor),
            itemTitleLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 12),
            itemTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            itemTitleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            
            itemNumberLabel.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: 4),
            itemNumberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            itemNumberLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            itemNumberLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    
    func configureCardType(CardType itemInfoType : itemInfoType , Count count : Int){
        switch itemInfoType {
        case .followers:
            itemImageView.image =  Images.person
            itemTitleLabel.text = "followers"
            
        case .following:
            itemImageView.image = Images.heart
            itemTitleLabel.text = "following"
 
        case .gists:
            itemImageView.image = Images.alignLeft
            itemTitleLabel.text = "Public Gists"

        case .publicRepos:
            itemImageView.image = Images.folder
            itemTitleLabel.text = "Public Repos"
        }
        itemNumberLabel.text = String(count)
    }
}
