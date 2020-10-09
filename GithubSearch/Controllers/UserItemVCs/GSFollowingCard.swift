//
//  GSFollowingCard.swift
//  GithubSearch
//
//  Created by Ahmad Sameh on 10/9/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.
//

import UIKit

class GSFollowingCard: GSItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureItems()
        
    }
    
    func configureItems(){
        
        itemViewOne.configureCardType(CardType: .following, Count: user.following)
        itemViewTwo.configureCardType(CardType: .followers, Count: user.followers)
        itemButton.setButtonProperties(color: .systemGreen, text: "Get Followers")
        
        
    }
}
