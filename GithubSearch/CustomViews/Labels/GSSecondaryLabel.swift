//
//  GSSecondaryLabel.swift
//  GithubSearch
//
//  Created by Ahmad Sameh on 10/8/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.
//

import UIKit

class GSSecondaryLabel: UILabel {


    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(fontSize : CGFloat) {
        super.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        configure()
        
    }
    
    
    private func configure(){
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
        minimumScaleFactor = 0.9
   
       
        
        
        
    }
}
