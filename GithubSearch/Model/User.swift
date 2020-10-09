//
//  User.swift
//  GithubSearch
//
//  Created by Ahmad Sameh on 9/28/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.
//

import Foundation
struct User : Codable{
    
    var login : String
    var htmlUrl : String
    var location: String?
    var followers: Int
    var following: Int
    var publicRepos : Int
    var publicGists : Int
    var avatarUrl : String
    var name : String?
    var bio : String?
    var createdAt : String
     
    
}
