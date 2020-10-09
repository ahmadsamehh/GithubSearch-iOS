//
//  UIViewController+Ext.swift
//  GithubSearch
//
//  Created by Ahmad Sameh on 9/28/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.
//

import UIKit

fileprivate var contentView : UIView!
extension UIViewController{
    func displayGF(title: String , message: String , buttonText : String){
        
        DispatchQueue.main.async {
            
            let alertVC = GSAlert(titlelabelText: title, messageLabelText: message, buttonTitle: buttonText)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true, completion: nil)
            
        }
        
        
    }
    
    
    func ShowLoadingAnimation(){
        contentView = UIView(frame: view.bounds)
        view.addSubview(contentView)
        contentView.backgroundColor = .systemBackground
        contentView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            contentView.alpha = 0.8
        }
        
        let loading = UIActivityIndicatorView(style: .large)
        contentView.addSubview(loading)
        
        loading.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loading.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            loading.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        loading.startAnimating()
    }
    
    
    func dismissLoadingAnimation(){
        
        DispatchQueue.main.async {
            contentView.removeFromSuperview()
            contentView = nil
        }
  
    }
    
    func showEmptyStateView(for messageTxt : String , view : UIView){
        
        let emptyStateView = GFEmptyStateView(messageText: messageTxt)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
        
    }
    
}

