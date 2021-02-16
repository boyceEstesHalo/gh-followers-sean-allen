//
//  UIView+Ext.swift
//  GHFollowers
//
//  Created by Boyce Estes on 7/20/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import UIKit

extension UIView {
    // views becomes an array that we can use in the scope of this function
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
    
    func pinToEdges(of superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.topAnchor),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor)
        ])
    }
}
