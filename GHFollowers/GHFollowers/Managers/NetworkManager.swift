//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Boyce Estes on 7/15/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let baseUrl = "https://api.github.com/users/"
    private let perPageFollowers = 100
    // create cache where it would only have one instance (so GFAvatarImageView would not be a good spot)
    let cache = NSCache<NSString, UIImage>()    // similar to a key value pair
    
    private init() { }
    
    
    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void) {
        let endpoint = baseUrl + "\(username)/followers?per_page=\(perPageFollowers)&page=\(page)"
        
        guard let url  = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                // convert from snake case to camel case
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                
                completed(.success(followers))
            } catch {
                completed(.failure(.invalidData))
//                completed(nil, "The data received from the server could not be decoded. Please try again.")
            }
        }
        
        task.resume()
    }
    
    
    func getUserInfo(for username: String, completed: @escaping (Result<User, GFError>) -> Void) {
        let endpoint = baseUrl + "\(username)"
        
        guard let url  = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                // convert from snake case to camel case
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601 // will convert date string in iso8601 format directly to a date object 
                let user = try decoder.decode(User.self, from: data)
                
                completed(.success(user))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    
    // Why place the download image function here instead of the network manager?
    // - it was weird to place this in the NetworkManager because we are not handling the errors in this
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        
        // each urlString should be unique so passing this to the cache should be fine
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            // if the image is cached, return to not download
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        // instead of showing an error we are going to show the placeholder image. Since this function will be called frequently, it is not a good idea to show alerts to display erros
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data)
            else {
                completed(nil)
                return
            }
            self.cache.setObject(image, forKey: cacheKey) // saves the image to the cache after downloading
            
            completed(image)
        }
        task.resume()
    }
}
