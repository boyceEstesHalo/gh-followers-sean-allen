//
//  GFCustomContainerView.swift
//  GHFollowers
//
//  Created by Boyce Estes on 7/20/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import UIKit

class GFCustomContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    
    private func configure() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 16
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
}
