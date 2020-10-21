//
//  UIView+Ext.swift
//  GithubSearch
//
//  Created by Ahmad Sameh on 10/20/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.
//

import UIKit

extension UIView {
    
    // Variadic functions
    func addSubviews(_ views : UIView...){
        for view in views {
            addSubview(view)
        }
    }
    
    
    
    
}
