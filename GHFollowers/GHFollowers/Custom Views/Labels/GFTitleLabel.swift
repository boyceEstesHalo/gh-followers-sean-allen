//
//  GFTitleLabel.swift
//  GHFollowers
//
//  Created by Boyce Estes on 7/15/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import UIKit

class GFTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Coder not implemented")
    }
    
    // convenience initializers has to call a designated initializer (required one for the object)
    // this allows us to not repeat configure() in this function and in the og init func
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame:.zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    private func configure() {
        textColor = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.90
        // if it becomes too big how does it break the line
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
