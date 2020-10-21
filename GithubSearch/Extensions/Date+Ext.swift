//
//  Date+Ext.swift
//  GithubSearch
//
//  Created by Ahmad Sameh on 10/11/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.
//

import Foundation

extension Date{
    
    
    func convertToString() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
