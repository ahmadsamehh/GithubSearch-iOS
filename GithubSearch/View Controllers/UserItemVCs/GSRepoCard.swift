//
//  GFRepoCard.swift
//  GithubSearch
//
//  Created by Ahmad Sameh on 10/9/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.
//

import UIKit

protocol GSRepoCardDelegate : class {
    func didTapGithubProfileBtn(user : User)
}

class GSRepoCard: GSItemInfoVC {
    
    var itemDelegate : GSRepoCardDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configueItem()
    }

    
    func configueItem(){
        itemViewOne.configureCardType(CardType: .publicRepos, Count: user.publicRepos)
        itemViewTwo.configureCardType(CardType: .gists, Count: user.publicGists)
        itemButton.setButtonProperties(color: .systemPurple, text: "Github Profile")
    }
   
    
    override func ActionBtnWasPressed() {
        itemDelegate?.didTapGithubProfileBtn(user: user)
    }
}
