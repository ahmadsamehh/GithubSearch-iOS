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
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
                
            }catch{
                completed(.failure(.invalidData))
            }
 
        }
        task.resume()
    }
    
    
    func downloadImage(for urlString : String , completed : @escaping (UIImage?) -> Void){
        
        if let image = NetworkManager.shared.cache.object(forKey: NSString(string: urlString) ) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let _ = self,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let data = data
                else {
                    completed(nil)
                    return
            }
            
            guard let image = UIImage(data: data) else {return}
            NetworkManager.shared.cache.setObject(image, forKey: NSString(string: urlString))
            
            completed(image)
        }
        task.resume()
    }
}

