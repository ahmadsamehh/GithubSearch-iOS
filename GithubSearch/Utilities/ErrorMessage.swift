//
//  ErrorMessage.swift
//  GithubSearch
//
//  Created by Ahmad Sameh on 9/29/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.
//

import Foundation

enum GSError : String, Error {
    case invalidUserName    = "Invalid username. Please double check."
    case unableToComplete   = "Unable to complete your request. Please check Internet connection."
    case invalidResponse    = "Invalid response from server. Please Try again."
    case invalidData        = "Invalid data received from the server. Please Try again."
    case unableToFavorite   = "There was an error favoriting this user!"
    case alreadyInFavorites = "This user is already in your favorites"
}
