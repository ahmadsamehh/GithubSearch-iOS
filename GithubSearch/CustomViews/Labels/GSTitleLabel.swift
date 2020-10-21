//
//  GSTitleLabel.swift
//  GithubSearch
//
//  Created by Ahmad Sameh on 9/27/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.
//

import UIKit

class GSTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    
    convenience init(textAllignment : NSTextAlignment , textSize : CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: textSize, weight: .bold)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        textColor                                   = .label
        adjustsFontSizeToFitWidth                   = true
        translatesAutoresizingMaskIntoConstraints   = false
        adjustsFontForContentSizeCategory           = true
        minimumScaleFactor                          = 0.9
        //if the text is bigger than the label
        lineBreakMode                               = .byTruncatingTail
 
    }
}
