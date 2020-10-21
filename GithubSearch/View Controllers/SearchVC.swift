//
//  SearchVC.swift
//  GithubSearch
//
//  Created by Ahmad Sameh on 9/24/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    let logo        = UIImageView()
    let searchField = GSTextField()
    let searchBtn   = GSButton(backgroundColor: .systemGreen, title: "Get Followers")
    var isSearchEmpty : Bool { return !searchField.text!.isEmpty }
    
   override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(true)
    
       navigationController?.setNavigationBarHidden(true, animated: true)
       searchField.text = ""
   }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubviews(logo,searchField,searchBtn)
        setLogoProperties()
        setEditTextProperties()
        setSearchBtnProperties()
        enableKeyboardDismiss()
    }
    
    
    func enableKeyboardDismiss(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    @objc func pushNavToFollowersListVC(){
        guard isSearchEmpty else {
            showGFAlert(title: "Empty Username", message: "Please double check that you entered a username\n We need to know who you're looking for 👻", buttonText: "ok")
            return
        }
        
        searchField.resignFirstResponder()
        let followersVC = FollowersListVC(username: searchField.text!)
        navigationController?.pushViewController(followersVC, animated: true)
    }
    
    
    func setLogoProperties(){
        logo.image =  Images.logo
        logo.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.widthAnchor.constraint(equalToConstant: 200),
            logo.heightAnchor.constraint(equalToConstant: 200)
        ])

    }
    
    
    func setEditTextProperties(){
        searchField.delegate = self
        
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 48),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            searchField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func setSearchBtnProperties(){
        searchBtn.addTarget(self, action: #selector (pushNavToFollowersListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            searchBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            searchBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            searchBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            searchBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}


extension SearchVC : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Go Pressed")
        pushNavToFollowersListVC()
        return true
    }
}
