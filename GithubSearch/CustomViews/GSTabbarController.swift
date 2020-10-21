//
//  GSTabbarController.swift
//  GithubSearch
//
//  Created by Ahmad Sameh on 10/15/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.
//

import UIKit

class GSTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor         = .systemGreen
        UINavigationBar.appearance().tintColor  = .systemGreen
        self.viewControllers                    = [createSearchVC(),createFavoritesVC()]
    }
    
    func createSearchVC() -> UINavigationController{
        let searchVC        = SearchVC()
        searchVC.title      = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createFavoritesVC() -> UINavigationController{
        let favsVC          = FavoritesVC()
        favsVC.title        = "Favorites"
        favsVC.tabBarItem   = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: favsVC)
    
    }


}
