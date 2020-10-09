//
//  NetworkManager.swift
//  GithubSearch
//
//  Created by Ahmad Sameh on 9/29/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.
//

import UIKit
class NetworkManager{
    
    static let shared   = NetworkManager()
    let cache           = NSCache<NSString,UIImage>()
    
    private init(){}
    let baseUrl = "https://api.github.com/users/"
    
    
    func getFollowersList(for username: String , page: Int , completed: @escaping (Result<[Follower],GSError>) -> Void){
      
        let endpoint = baseUrl + username + "/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else{
            completed(.failure(.invalidUserName))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let data = data else{
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                //we used snakecase to rename variable instead of camel case
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
                
                
            }catch{
                completed(.failure(.invalidData))
                
            }
            
        }
        
        task.resume()
    }
    
    
    func getUserInfo(for username : String , completed : @escaping (Result<User,GSError>) -> Void){
        let endpoint = baseUrl + username
        guard let url = URL(string: endpoint) else {
            print("invalid url")
            completed(.failure(.invalidUserName))
            return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else{
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
                
            }catch{
                completed(.failure(.invalidData))
            }
            
            
        }
        task.resume()
    }
    
    
}
