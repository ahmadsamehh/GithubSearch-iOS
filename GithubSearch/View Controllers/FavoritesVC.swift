//
//  FavoritesVC.swift
//  GithubSearch
//
//  Created by Ahmad Sameh on 9/24/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController {
    
    let tableView               = UITableView()
    var favorites : [Follower]  = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getFavorites()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    
    func configureViewController(){
        view.backgroundColor                                    = .systemBackground
        title                                                   = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles  = true
    }
    
    
    func configureTableView(){
        view.addSubview(tableView)
        tableView.delegate      = self
        tableView.dataSource    = self
        tableView.frame         = view.bounds
        tableView.rowHeight     = 80
        tableView.removeExcessCells()
        
        //Must use function
        tableView.register(FavoriteCell.self , forCellReuseIdentifier: FavoriteCell.reuseID)
    }
    
    
    func getFavorites(){
        PersistanceManager.retreiveFollowers { (result) in
            switch result{
            case .success(let favfollowers):
                if favfollowers.isEmpty {
                    self.showEmptyStateView(for: "No Favs??\nAdd some now 👯‍♂️ ", view: self.view)
                    self.tableView.isHidden = true
                }else{
                    self.favorites = favfollowers
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.tableView.isHidden = false
                    }
                }
                
            case .failure(let error):
                self.showGFAlert(title: "OOPS", message: error.rawValue, buttonText: "Ok")
            }
        }
        
    }
    
}


extension FavoritesVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID, for: indexPath) as! FavoriteCell
        let favFollower = favorites[indexPath.row]
        cell.set(favorite: favFollower)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite            = favorites[indexPath.row]
        let destinationVC       = FollowersListVC(username: favorite.login)
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        
        PersistanceManager.updateWith(favorite: favorites[indexPath.row], actionType: .remove) { [weak self](error) in
            guard let self = self else {return}
            guard let error = error else {
                self.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                return}
            self.showGFAlert(title: "Something went wrong", message: error.rawValue, buttonText: "Ok!")
        }
    }
    
}
