//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Boyce Estes on 7/15/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import UIKit

class FollowerListVC: GFLoadingDataVC {
    // enums are hashable by default
    enum Section { case main }

    var username: String!
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    var isSearching = false
    var isLoadingMoreFollowers = false
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title = username
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        configureDataSource()
        getFollowers(username: username, page: page)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    
//    // Does the view controller NEED to know this? A good rule of alarm is if you only see white and purple, it doesn't directly tie into the collectionView property and can be refactored into its own file
//    func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
//        let width = view.bounds.width
//        let padding: CGFloat = 12
//        let minimumItemSpacing: CGFloat = 10
//        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
//        let itemWidth = availableWidth / 3
//        
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
//        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
//        
//        return flowLayout
//    }

    
    func getFollowers(username: String, page: Int) {
        showLoadingView()
        isLoadingMoreFollowers = true
        
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] (result) in
            // unwrapping self so it doesn't have to be optional
            guard let self = self else { return }
            self.dismissLoadingView()
            
            // has a strong reference to self (FollowerListVC), so this could be a possible memory leak if FollowerListVC is deallocated while this is happening (i think(?))
            // [weak self] is called a capture list - [unowned self] will force unwrap self itself, this is a little more dangerous
            switch result {
            case .success(let followers):
                self.updateUI(followers: followers)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "Ok")
            }
            
            self.isLoadingMoreFollowers = false
//            * without the Result niceness *
//            guard let followers = followers else {
//                self.presentGFAlertOnMainThread(title: "Bad Stuff Happened", message: errorMessage!.rawValue, buttonTitle: "Ok")
//                return
//            }
//
//            print("Followers.count = \(followers.count)")
//            print(followers)
        }
    }
    
    
    func updateUI(followers: [Follower]) {
        if followers.count < 100 { self.hasMoreFollowers = false }
        self.followers.append(contentsOf: followers) // append so we can get the next page of followers
        
        // is empty is more efficient than checking if followers.count == 0
        if self.followers.isEmpty {
            let message = "This user doesn't have any followers. Go follow them 😀"
            DispatchQueue.main.async{ self.showEmptyStateView(with: message, in: self.view) }
            return
        }
        self.updateData(on: self.followers)
    }
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    
    // call everytime we take a snapshot and we want to update our data
    func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        
        // apply the snapshot after it is applied
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
    
    
    @objc func addButtonTapped() {
        showLoadingView()
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                
                PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] (error) in
                    guard let self = self else { return }
                    
                    guard let error = error else {
                        self.presentGFAlertOnMainThread(title: "Success!", message: "You have successfully saved this user! 🎉", buttonTitle: "Horray!")
                        return
                    }
                    
                    self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}

extension FollowerListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height   // the entire scrollView (ex: it'd be really big with 3000 items)
        let height = scrollView.frame.size.height   //
        
//        print("OffsetY = \(offsetY)")
//        print("contentHeight = \(contentHeight)")
//        print("height = \(height)")
        
        // if we are at the end of the scroll
        if offsetY > contentHeight - height {
            // isLoadingMoreFollowers allows us to not make repeated network calls on a slower connection
            guard hasMoreFollowers, !isLoadingMoreFollowers else { print("We're at the end!"); return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredFollowers : followers
        let follower = activeArray[indexPath.item]
        
        let destVC = UserInfoVC()
        destVC.username = follower.login
        destVC.delegate = self
        
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}

extension FollowerListVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        // filter array
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredFollowers.removeAll()
            updateData(on: followers)
            return
        }
        isSearching = true
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)
    }
    
}


extension FollowerListVC: UserInfoVCDelegate {
    func didRequestFollowers(for username: String) {
        // get followers for that user
        self.username = username
        title = username
        page = 1
        followers.removeAll()
        filteredFollowers.removeAll()
//        collectionView.setContentOffset(.zero, animated: true) -- replaced with below
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(username: username, page: page)
    }
}
