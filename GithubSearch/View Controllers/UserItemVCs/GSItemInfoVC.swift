//
//  GFItemInfoVC.swift
//  GithubSearch
//
//  Created by Ahmad Sameh on 10/9/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.
//

import UIKit




class GSItemInfoVC: UIViewController {
    
    let stackView   = UIStackView()
    let itemButton  = GSButton()
    let itemViewOne = ItemInfoView()
    let itemViewTwo = ItemInfoView()

    var user : User!
    
    init(user : User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainView()
        configureConstraints()
        configureButtonAction()
        configureStackView()
    }
    

    func configureMainView(){
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 20
    }
    
    
    func configureStackView(){
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(itemViewOne)
        stackView.addArrangedSubview(itemViewTwo)
    }
    
    
    func configureButtonAction(){
        itemButton.addTarget(self, action: #selector(ActionBtnWasPressed), for: .touchUpInside)
    }
    
    @objc func ActionBtnWasPressed(){
    }
    
    
    func configureConstraints(){
        view.addSubviews(stackView,itemButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding : CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor , constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            itemButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: padding),
            itemButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  padding),
            itemButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -padding),
            itemButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }    
}
