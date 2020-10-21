//
//  PersistenceManager.swift
//  GithubSearch
//
//  Created by Ahmad Sameh on 10/13/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.
//

import Foundation

enum PersistanceActionType{
    
    case add,remove
}


enum PersistanceManager{
    
    private static let defaults = UserDefaults.standard
    enum Keys{ static let favorites = "favourites"}
    
    static func updateWith(favorite : Follower , actionType : PersistanceActionType , completed : @escaping (GSError?)-> Void){
        PersistanceManager.retreiveFollowers { result in
            switch result {
            case .success(var favorites):
                switch actionType {
                case .add:
                    guard !favorites.contains(favorite) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    favorites.append(favorite)
                    
                case .remove:
                    favorites.removeAll { $0.login == favorite.login }
                }
                
                completed(saveToFavorites(followers: favorites))
   
            case .failure(let error):
                completed(error)
                
            }
            
        }
        
    }
    
    
    static func retreiveFollowers(completed : @escaping (Result<[Follower],GSError>) -> Void){
        guard let favouritesData = PersistanceManager.defaults.data(forKey: Keys.favorites) else {
            completed(.success([]))
            return
        }
        
        do{
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favouritesData)
            completed(.success(favorites))
        }catch{
            completed(.failure(.unableToFavorite))
        }
    }
    
    
    static func saveToFavorites(followers : [Follower]) -> GSError? {
        do{
            let encoder = JSONEncoder()
            let encodedFavoritesData = try encoder.encode(followers)
            PersistanceManager.defaults.set(encodedFavoritesData, forKey: Keys.favorites)
            
            return nil
        }catch{
            return .unableToFavorite
        }
        
    }
    
}

