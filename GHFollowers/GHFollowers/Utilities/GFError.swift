//
//  ErrorMessage.swift
//  GHFollowers
//
//  Created by Boyce Estes on 7/15/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import Foundation

// raw value, all cases are one type
// associated value, each case has its own value type

enum GFError: String, Error {
    case invalidUsername = "This username created an invalid request. Please try again"
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case unableToFavorite = "There was an error favoriting this user. Please try again."
    case alreadyInFavorites = "You've already favorited this user. You must REALLY like them!"
}
