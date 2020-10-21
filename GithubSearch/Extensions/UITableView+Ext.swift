//
//  UITableView+Ext.swift
//  GithubSearch
//
//  Created by Ahmad Sameh on 10/21/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.
//

import UIKit

extension UITableView{
    
    func removeExcessCells(){
        tableFooterView = UIView(frame: .zero)
    } 
}
