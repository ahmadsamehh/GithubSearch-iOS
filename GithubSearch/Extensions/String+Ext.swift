//
//  String+Ext.swift
//  GithubSearch
//
//  Created by Ahmad Sameh on 10/11/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.
//

import Foundation

extension String {

    func convertToDate() -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        
        return dateFormatter.date(from: self)
    }
    
    
    func getFormattedDate() -> String{
        guard let convertedFinalDate = self.convertToDate() else {return "No date specified"}
        return convertedFinalDate.convertToString()
    }
}

