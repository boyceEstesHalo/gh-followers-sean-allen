//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by Boyce Estes on 7/19/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import UIKit

// this is here instead of the superclass because we don't want this delegate to be able to trigger a didTapGithubFollowers func
// so we made each func a separate protocol for each ItemVC
protocol GFRepoItemVCDelegate: class {
    func didTapGithubProfile(for user: User)
}

class GFRepoItemVC: GFItemInfoVC {
    // this avoids retain cycles
    weak var delegate: GFRepoItemVCDelegate!

    init(user: User, delegate: GFRepoItemVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.setBackgroundColor(color: .systemPurple, title: "GitHub Profile")
    }
    
    
    override func actionButtonTapped() {
        delegate.didTapGithubProfile(for: user)
    }

}
