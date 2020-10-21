//
//  ViewController.swift
//  GithubSearch
//
//  Created by Ahmad Sameh on 9/24/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.
//


import UIKit
import SafariServices

protocol UserInfoVCDelegate : class {
    func didRequestFollowers(userName : String)
}

class UserInfoVC: UIViewController {
    var username : String!
    let headerView          = UIView()
    let viewOne             = UIView()
    let viewTwo             = UIView()
    let dateLabel           = GSBodyLabel(textAllignment: .center)
    var views : [UIView]    = []
    weak var userInfoDelegate : UserInfoVCDelegate?
    
    
    init(username : String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewDidLoad()
        configureContainerView()
        getCurrentUserInfo(for: username)
    }
    
    
    func configureViewDidLoad(){
        let doneBtn                             = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector (dismissCurrentView))
        navigationItem.rightBarButtonItem       = doneBtn
        navigationItem.largeTitleDisplayMode    = .always
        
    }
    
    
    func add(child ChildVC : UIViewController , for containerView : UIView){
        addChild(ChildVC)
        containerView.addSubview(ChildVC.view)
        ChildVC.view.frame = containerView.bounds
        didMove(toParent: self)
    }
    
    
    func getCurrentUserInfo(for username : String){
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let user) :
                DispatchQueue.main.async { self.configureChildVCsWithUser(for: user) }
                
            case .failure(let error):
                self.showGFAlert(title: "Error", message: error.rawValue, buttonText: "OK!")
            }
        }
    }
    
    
    func configureChildVCsWithUser(for user : User){
        let repoCardVC = GSRepoCard(user: user)
        repoCardVC.itemDelegate = self
        
        let followingCard = GSFollowingCard(user: user)
        followingCard.itemDelegate = self
        
        self.add(child: GSUserHeaderVC(currentUser: user), for: self.headerView)
        self.add(child: followingCard, for: self.viewTwo)
        self.add(child: repoCardVC, for: self.viewOne)
        self.dateLabel.text = "Github since \(user.createdAt.convertToString())"
    }
    
    
    func configureContainerView(){
        views = [headerView,viewOne,viewTwo,dateLabel]
        
        for item in views {
            view.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
        }
        
        view.backgroundColor = .systemBackground
        let padding : CGFloat = 20
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 190),
            
            
            viewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 25),
            viewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: padding),
            viewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -padding),
            viewOne.heightAnchor.constraint(equalToConstant: 140),
            
            
            viewTwo.topAnchor.constraint(equalTo: viewOne.bottomAnchor, constant: padding),
            viewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            viewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            viewTwo.heightAnchor.constraint(equalToConstant: 140),
            
            
            
            
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            dateLabel.topAnchor.constraint(equalTo: viewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    
    @objc func dismissCurrentView(){
        dismiss(animated: true, completion: nil)
    }
}



extension UserInfoVC : GSFollowingCardDelegate {
    
    func didTapGetFollowersBtn(user: User) {
        guard  user.followers != 0 else {
            showGFAlert(title: "Oops", message: "This user has no followers, what a shame! 😅", buttonText: "so sad")
            return
        }
        userInfoDelegate?.didRequestFollowers(userName: user.login)
        dismissCurrentView()
    }
    
}


extension UserInfoVC : GSRepoCardDelegate {
    
    func didTapGithubProfileBtn(user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            print("invalid url")
            return
        }
        
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true, completion: nil)
    }
    
}


