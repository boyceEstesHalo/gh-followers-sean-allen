//
//  GFBodyLabel.swift
//  GHFollowers
//
//  Created by Boyce Estes on 7/15/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import UIKit

class GFBodyLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Coder not implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame:.zero)
        self.textAlignment = textAlignment
        self.font = UIFont.preferredFont(forTextStyle: .body)
    }
    
    private func configure() {
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        adjustsFontForContentSizeCategory = true
        minimumScaleFactor = 0.75
        // if it becomes too big how does it break the line
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
}
