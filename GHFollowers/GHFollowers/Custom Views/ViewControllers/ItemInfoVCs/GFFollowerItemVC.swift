//
//  GFFollowerItemVC.swift
//  GHFollowers
//
//  Created by Boyce Estes on 7/19/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import UIKit

protocol GFFollowerItemVCDelegate: class {
    func didTapGithubFollowers(for user: User)
}

class GFFollowerItemVC: GFItemInfoVC {
    // this avoids retain cycles
    weak var delegate: GFFollowerItemVCDelegate!
    
    init(user: User, delegate: GFFollowerItemVCDelegate) {
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
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.setBackgroundColor(color: .systemGreen, title: "Get Followers")
    }
    
    
    override func actionButtonTapped() {
        delegate.didTapGithubFollowers(for: user)
    }
}
