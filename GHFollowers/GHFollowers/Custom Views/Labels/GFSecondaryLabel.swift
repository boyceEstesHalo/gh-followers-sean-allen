//
//  GFSecondaryLabel.swift
//  GHFollowers
//
//  Created by Boyce Estes on 7/19/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Coder not implemented")
    }
    
    init(fontSize: CGFloat) {
        super.init(frame:.zero)
        self.textAlignment = .left
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        configure()
    }
    
    private func configure() {
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.90
        // if it becomes too big how does it break the line
        lineBreakMode = .
        translatesAutoresizingMaskIntoConstraints = false
    }
}
