//
//  PersistenceManager.swift
//  GHFollowers
//
//  Created by Boyce Estes on 7/19/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

// can't initialize an empty enum (unlike struct)
enum PersistenceManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func updateWith(favorite: Follower, actionType: PersistenceActionType, completed: @escaping (GFError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(var favorites): // this can be a mutable array so we don't need to create retrievedFavorites
                
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
                
                completed(save(favorites: favorites))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retrieveFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            // first time use could come here
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }
    
    
    static func save(favorites: [Follower]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return  nil
        } catch {
            return .unableToFavorite
        }
    }
    
    
}
