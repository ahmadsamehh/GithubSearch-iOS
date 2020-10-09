//
//  containerView.swift
//  GithubSearch
//
//  Created by Ahmad Sameh on 9/27/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.
//

import UIKit

class ContainerView: UIView {

    
    let titleLabel      = GSTitleLabel(textAllignment: .center, textSize: 20)
    let messageLabel    = GSBodyLabel(textAllignment: .center)
    let actionBtn       = GSButton(backgroundColor: .systemRed, title: "ok")
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       
        
    }
    

    
    func config() {
        configuretitleLabel()
        configureBodyLabel()
        configureActionBtn()
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configuretitleLabel() {
        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
        
        
    }
    
    
    private func configureActionBtn(){
        self.addSubview(actionBtn)
        

        NSLayoutConstraint.activate([
            actionBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            actionBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            actionBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            actionBtn.heightAnchor.constraint(equalToConstant: 44)
        ])
        
    }
    
    
    private func configureBodyLabel(){
        self.addSubview(messageLabel)
        NSLayoutConstraint.activate([
            
            messageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            messageLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -60)
        ])
  
    }
 


    

    
}
