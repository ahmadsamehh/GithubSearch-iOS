//
//  FollowersListVC.swift
//  GithubSearch
//
//  Created by Ahmad Sameh on 9/25/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.


import UIKit


class FollowersListVC: UIViewController, UICollectionViewDelegate{
    
    enum Section { case main }
    
    
    var followers : [Follower]          = []
    var filteredFollowes : [Follower]   = []
    var page : Int                      = 1
    var hasMoreFollowers                = true
    var isSearching                     = false
    var isLoadingFollowers              = false
    let searchController                = UISearchController()
    var username        : String!
    var collectionView  : UICollectionView!
    var dataSource      : UICollectionViewDiffableDataSource<Section,Follower>!
    
    
    init(username : String) {
        super.init(nibName: nil, bundle: nil)
        self.username   = username
        title           = username
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewDidload()
        configureSearchBar()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
    }
    
    
    func configureViewDidload(){
        navigationController?.isNavigationBarHidden            = false
        view.backgroundColor                                   = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        configureAddToFavsButton()
    }
    
    
    func configureSearchBar(){
        searchController.searchResultsUpdater                   = self
        searchController.searchBar.placeholder                  = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation   = false
        navigationItem.searchController = searchController
    }
    
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.customThreeColumnLayout(for: view))
        collectionView.delegate             = self
        view.addSubview(collectionView)
        collectionView.backgroundColor      = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func getFollowers(username: String , page : Int){
        ShowLoadingAnimation()
        isLoadingFollowers = true
        NetworkManager.shared.getFollowersList(for: username, page: page) { [weak self]result in
            guard let self = self else{return}
            self.dismissLoadingAnimation()
            switch result{
            case .success(let followers):
                if followers.count < 100 {self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                if followers.isEmpty {
                    DispatchQueue.main.async {self.showEmptyStateView(for: "Sorry, this user has no followers ☹️", view: self.view)}
                    return
                }
                self.updateData(on: self.followers)
                
            case .failure(let error):
                self.showGFAlert(title: "Error", message: error.rawValue, buttonText: "Ok")
                
            }
            
            self.isLoadingFollowers = false
            
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
        DispatchQueue.main.async {self.dataSource.apply(snapshot, animatingDifferences: true, completion: nil)}
    }
    
    
    func configureAddToFavsButton(){
        let addFavBtn                     = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addUserToFavs))
        navigationItem.rightBarButtonItem = addFavBtn
    }
    
    
    @objc func addUserToFavs(){
        ShowLoadingAnimation()
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else {return }
            self.dismissLoadingAnimation()
            switch result{
            case .success(let user):
                let toBeFavFollower = Follower(login: user.login, avatarUrl: user.avatarUrl)
                
                PersistanceManager.updateWith(favorite: toBeFavFollower, actionType: .add) { [weak self] (error) in
                    guard let self = self else {return }
                    guard let error = error else {
                        self.showGFAlert(title: "Success", message: "User succesfully added to favorites 🥳", buttonText: "Great!")
                        return
                    }
                    self.showGFAlert(title: "Something went wrong!", message: error.rawValue, buttonText: "ok")
                }
            case .failure(let error):
                self.showGFAlert(title: "Error!", message: error.rawValue , buttonText: "Ok")
            }
        }
    }
}



extension FollowersListVC : UIScrollViewDelegate{
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - screenHeight {
            guard  hasMoreFollowers, !isLoadingFollowers  else {return}
            page += 1
            getFollowers(username: username, page: page)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeFollowersList = isSearching ? filteredFollowes : followers
        guard activeFollowersList.count != 0 else {
            print("empty list")
            return
        }
        let follower                = activeFollowersList[indexPath.item]
        let userInfo                = UserInfoVC(username: follower.login)
        userInfo.userInfoDelegate   = self
        let navigationController    = UINavigationController(rootViewController: userInfo)
        present(navigationController, animated: true, completion: nil)
    }
}


extension FollowersListVC : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filterText = searchController.searchBar.text, !filterText.isEmpty else {
            filteredFollowes.removeAll()
            isSearching      = false
            updateData(on: followers)
            
            return
        }
        isSearching      = true
        filteredFollowes = followers.filter{ ($0.login.lowercased().contains(filterText.lowercased()))}
        updateData(on: filteredFollowes)
    }
}


extension FollowersListVC : UserInfoVCDelegate{
    
    func didRequestFollowers(userName: String) {
        //request new followers and restart the ViewController
        self.username   = userName
        title           = userName
        page            = 1
        followers.removeAll()
        filteredFollowes.removeAll()
        collectionView.scrollsToTop = true
        isSearching = false
        getFollowers(username: userName, page: page)
        
    }
}
