//
//  FollowersListVC.swift
//  GithubSearch
//
//  Created by Ahmad Sameh on 9/25/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.


import UIKit

class FollowersListVC: UIViewController, UICollectionViewDelegate{

    enum Section { case main }
    
    var username : String!
    var followers : [Follower] = []
    var filteredFollowes : [Follower] = []
    var page : Int = 1
    var hasMoreFollowers = true
    var isSearching = false
    
    var collectionView : UICollectionView!
    var dataSource : UICollectionViewDiffableDataSource<Section,Follower>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewDidload()
        configureSearchBar()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)

    }

    
    func configureViewDidload(){
        navigationController?.isNavigationBarHidden = false
        print("new vc \(self.username ?? "username")")
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureSearchBar(){
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        
    }
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.customThreeColumnLayout(for: view))
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        
        
    }
    
    func getFollowers(username: String , page : Int){
        ShowLoadingAnimation()
        NetworkManager.shared.getFollowersList(for: username, page: page) { [weak self]result in
            guard let self = self else{return}

            self.dismissLoadingAnimation()
            switch result{
            case .success(let followers):
                
                print("Followers count = \(followers.count)")
                print(followers)
                if followers.count < 100 {
                    self.hasMoreFollowers = false
                    
                }

                
                self.followers.append(contentsOf: followers)
                
                if followers.isEmpty {
                    DispatchQueue.main.async {
                        self.showEmptyStateView(for: "Sorry, this user has no followers ☹️", view: self.view)

                    }
                    return
                }
                self.updateData(on: self.followers)
                break
                
            case .failure(let error):
                self.displayGF(title: "Error", message: error.rawValue, buttonText: "Ok")
                break
                
                
            }
        
            
            
        }
        
    }
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: collectionView, cellProvider: { (collectionView, indePath, follower) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indePath) as! FollowerCell
            cell.setInfo(follower: follower)
            return cell
            
            
        })
        
        
    }
    
    func updateData(on followers : [Follower]){
        var snapshot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true, completion: nil)

        }
        
        
    }
}

extension FollowersListVC : UIScrollViewDelegate{
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        

        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
        
        
//        print("OffsetY = \(offsetY)")
//
//        print("contentHeight = \(contentHeight)")
//        print("screenHeight = \(screenHeight)")
//
//        print("minus = \(contentHeight - screenHeight)")
        
        
        if offsetY > contentHeight - screenHeight {

            guard  hasMoreFollowers else {return}
            
            page += 1
            getFollowers(username: username, page: page)
        }
        
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let activeFollowersList = isSearching ? filteredFollowes : followers
        
        let follower = activeFollowersList[indexPath.item]
        
        let userInfo = UserInfoVC()
        userInfo.username = follower.login
        let navigationController = UINavigationController(rootViewController: userInfo)
        
        present(navigationController, animated: true, completion: nil)
        
    }
    
    
}


extension FollowersListVC : UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        guard let filterText = searchController.searchBar.text, !filterText.isEmpty else {return}
        isSearching = true
        filteredFollowes = followers.filter{ ($0.login.lowercased().contains(filterText.lowercased()))}
        updateData(on: filteredFollowes)
        
        
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        print("Cancel Clicked")
        updateData(on: followers)
    }
    
    
    
}
