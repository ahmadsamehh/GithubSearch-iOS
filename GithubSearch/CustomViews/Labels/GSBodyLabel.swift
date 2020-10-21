//
//  GSBodyLabel.swift
//  GithubSearch
//
//  Created by Ahmad Sameh on 9/27/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.
//

import UIKit

class GSBodyLabel: UILabel {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    convenience init(textAllignment : NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAllignment
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func configure(){
        textColor                                   = .secondaryLabel
        adjustsFontSizeToFitWidth                   = true
        translatesAutoresizingMaskIntoConstraints   = false
        adjustsFontForContentSizeCategory           = true
        font = UIFont.preferredFont(forTextStyle: .body)
        lineBreakMode                               = .byWordWrapping
        minimumScaleFactor                          = 0.75
    }
}
