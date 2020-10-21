//
//  GSAlert.swift
//  GithubSearch
//
//  Created by Ahmad Sameh on 9/27/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.
//

import UIKit

class GSAlert: UIViewController {
    let myContainerView = ContainerView(frame: .zero)
    
    
    init(titlelabelText: String , messageLabelText: String , buttonTitle: String) {
        
        super.init(nibName: nil, bundle: nil)
        config()
        self.myContainerView.titleLabel.text            = titlelabelText
        self.myContainerView.messageLabel.text          = messageLabelText
        self.myContainerView.actionBtn.titleLabel?.text = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  UIColor.black.withAlphaComponent(0.75)
        config()
    }
    
    
    
    private func config(){
        view.addSubview(myContainerView)
        myContainerView.actionBtn.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        myContainerView.messageLabel.numberOfLines = 4
        myContainerView.layer.cornerRadius         = 16
        myContainerView.layer.borderWidth          = 2
        myContainerView.layer.borderColor          = UIColor.white.cgColor
        myContainerView.backgroundColor            = .systemBackground
        myContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            myContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            myContainerView.widthAnchor.constraint(equalToConstant: 280),
            myContainerView.heightAnchor.constraint(equalToConstant: 220)
        ])
        myContainerView.config()
    }
    
    
    
    @objc func dismissVC(){
        dismiss(animated: true, completion: nil)
    }
}
