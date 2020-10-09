//
//  UIHelper.swift
//  GithubSearch
//
//  Created by Ahmad Sameh on 10/1/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.
//

import UIKit

 struct UIHelper {
   static func customThreeColumnLayout(for view: UIView) -> UICollectionViewFlowLayout{
        
        let width = view.bounds.width
        let padding : CGFloat = 12
        let spacing : CGFloat = 10
        let availableSpace = width - (2*padding) - (2*spacing)
        let itemWidth = availableSpace/3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        return flowLayout
        
        
    }
}

