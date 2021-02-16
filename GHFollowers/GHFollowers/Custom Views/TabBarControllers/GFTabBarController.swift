//
//  GFTabBarController.swift
//  GHFollowers
//
//  Created by Boyce Estes on 7/20/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import UIKit

class GFTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchNC(), createFavoriteListNC()]
    }
    
    
    func createSearchNC() -> UINavigationController {
        // configure the search View Controller and return navigation controller that it is embedded in
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    
    func createFavoriteListNC() -> UINavigationController {
        // configure the search View Controller and return navigation controller that it is embedded in
        let favoriteListVC = FavoriteListVC()
        favoriteListVC.title = "Favorites"
        favoriteListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoriteListVC)
    }
    
    

}
