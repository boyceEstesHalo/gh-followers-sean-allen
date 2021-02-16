//
//  GFButton.swift
//  GHFollowers
//
//  Created by Boyce Estes on 7/15/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import UIKit

class GFButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    // this is initialized via storyboard - in this
    // project, it will not matter since this project
    // does not use storyboard
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame:.zero) // we'll do this with autolayout constraints
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }
    
    // good practice. We don't want someone to configure the button outside this class
    private func configure() {
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
        // conform to dynamic type with preferredFont
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setBackgroundColor(color: UIColor, title: String) {
        self.backgroundColor = color
        setTitle(title, for: .normal)
    }
}
