//
//  EmptyStateView.swift
//  GHFollowers
//
//  Created by Boyce Estes on 7/18/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import UIKit

class GFEmptyStateView: UIImageView {
    
    let messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    
    private func configure() {
        addSubviews(messageLabel, logoImageView)
        
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        
        logoImageView.image = Images.emptyStateLogo
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // do something similar to the search vc where we move down the constraints if the size messes up on iPhone SE
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
            
            // make the width of the image 1.3x as large as the screen.
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            // we want the height = width
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            // instead of the usual negative value, we would need a positive value
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40)
        ])
    }

}
