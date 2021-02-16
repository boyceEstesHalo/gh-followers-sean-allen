//
//  FavoriteListVC.swift
//  GHFollowers
//
//  Created by Boyce Estes on 7/1/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import UIKit

class FavoriteListVC: GFLoadingDataVC {
    
    let tableView = UITableView()
    var favorites: [Follower] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.dataSource = self
        tableView.delegate = self
        tableView.removeExcessCells()
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }
    
    
    func getFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let favorites):
                if favorites.isEmpty {
                    self.showEmptyState()
                } else {
                    self.configureTableView()
                    self.favorites = favorites
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        // in case the empty state view gets populated before our tableview
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func showEmptyState() {
        self.showEmptyStateView(with: "No favorites?\nAdd one on the follower screen", in: self.view)
    }
}

// place in a separate file if this was more complicated
extension FavoriteListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
        let favorite = self.favorites[indexPath.row]
        cell.set(favorite: favorite)
        return cell
    }
    
    // did select
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = self.favorites[indexPath.row]
        let destVC = FollowerListVC(username: favorite.login)
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    
    // delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let favorite = self.favorites[indexPath.row]
        
        PersistenceManager.updateWith(favorite: favorite, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            
            guard let error = error else {
                self.favorites.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .left)
                
                if self.favorites.isEmpty {
                    self.showEmptyState()
                    self.tableView.removeFromSuperview()
                }
                return
                
            }
            self.presentGFAlertOnMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
        }
        
        
        
        
        
        

    }
}
