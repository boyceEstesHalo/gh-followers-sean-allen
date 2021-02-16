//
//  GFAvatarView.swift
//  GHFollowers
//
//  Created by Boyce Estes on 7/16/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let placeholderImage = UIImage(named:"avatar-placeholder-dark")
    
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
}


