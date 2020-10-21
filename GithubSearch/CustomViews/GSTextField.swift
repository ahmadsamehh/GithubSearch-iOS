//
//  GSTextField.swift
//  GithubSearch
//
//  Created by Ahmad Sameh on 9/24/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.
//

import UIKit

class GSTextField: UITextField {


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        customTextField()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func customTextField(){
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius  = 10
        layer.borderWidth   = 2
        layer.borderColor   = UIColor.systemGray4.cgColor
        textColor           = .label
        tintColor           = .label
        textAlignment       = .center
        font                = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize     = 12
        backgroundColor     = .tertiarySystemBackground
        autocorrectionType  = .no
        returnKeyType       = .go
        clearButtonMode     = .whileEditing
        placeholder         = "Enter a username!"
 
    }
}
