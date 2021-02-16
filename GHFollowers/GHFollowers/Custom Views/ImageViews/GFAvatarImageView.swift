//
//  GFAvatarView.swift
//  GHFollowers
//
//  Created by Boyce Estes on 7/16/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let cache = NetworkManager.shared.cache
    let placeholderImage = Images.placeholder
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius = 10
        // this will make the UIImage inside clip to the frame's rounded edges
        clipsToBounds = true
        image = placeholderImage!
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(fromURL url: String) {
        NetworkManager.shared.downloadImage(from: url) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.image = image }
        }
    }
    
    
    // Moved this into Network Manager
//    func downloadImage(from urlString: String) {
//        
//        // each urlString should be unique so passing this to the cache should be fine
//        let cacheKey = NSString(string: urlString)
//        if let image = cache.object(forKey: cacheKey) {
//            // if the image is cached, return to not download
//            self.image = image
//            return
//        }
//        
//        guard let url = URL(string: urlString) else { return }
//        // instead of showing an error we are going to show the placeholder image. Since this function will be called frequently, it is not a good idea to show alerts to display erros
//        
//        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
//            guard let self = self else { return }
//            
//            // Don't really handle the errors
//            if error != nil { return }
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
//            guard let data = data else { return }
//            
//            guard let image = UIImage(data: data) else { return }
//            self.cache.setObject(image, forKey: cacheKey) // saves the image to the cache after downloading
//            
//            DispatchQueue.main.async { self.image = image }
//        }
//        task.resume()
//    }
}


