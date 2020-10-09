//
//  GSUserHeaderVC.swift
//  GithubSearch
//
//  Created by Ahmad Sameh on 10/8/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.
//

import UIKit

class GSUserHeaderVC: UIViewController {

    //Variables
    var currentUser : User!
    
    //Views
    let avatarImageView = AvatarImageView(frame: .zero)
    let loginLabel = GSTitleLabel(textAllignment: .left, textSize: 34)
    let nameLabel = GSSecondaryLabel(fontSize: 18)
    let locationLabel = GSSecondaryLabel(fontSize: 18)
    let locationImageView = UIImageView()
    let bioLabel = GSBodyLabel(textAllignment: .left)
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        addConstraints()
        configureDataInUIElements()
        
        
    }
    
    
    func addSubviews(){
        view.addSubview(avatarImageView)
        view.addSubview(loginLabel)
        view.addSubview(nameLabel)
        view.addSubview(locationImageView)
        view.addSubview(locationLabel)
        view.addSubview(bioLabel)
        
    }
    
    
     init(currentUser : User) {
        super.init(nibName: nil, bundle: nil)
        
        self.currentUser = currentUser
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureDataInUIElements(){
        avatarImageView.getImage(for: currentUser.avatarUrl)
        loginLabel.text = currentUser.login
        nameLabel.text = currentUser.name ?? ""
        locationLabel.text = currentUser.location ?? "No Location"
        bioLabel.text = currentUser.bio ?? "No Bio available"
        bioLabel.numberOfLines = 3
        locationImageView.image = UIImage(systemName: "mappin.and.ellipse")
        locationImageView.tintColor = .secondaryLabel
        
        
    }
    
    
    func addConstraints(){
        let padding : CGFloat = 20
        let spacing : CGFloat = 12
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        bioLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            
            
            loginLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            loginLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            loginLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: spacing),
            loginLabel.heightAnchor.constraint(equalToConstant: 38),
            
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: spacing),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: spacing),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: spacing),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            bioLabel.heightAnchor.constraint(equalToConstant: 60)

        ])
        
    }
    



}
