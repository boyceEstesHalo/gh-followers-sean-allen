//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Boyce Estes on 7/15/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import UIKit
import SafariServices

// anything in this file can use this variable
fileprivate var containerView: UIView!

extension UIViewController {
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .fullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
//    // move to its own subclass that would be specifically for view controllers that load data
//    func showLoadingView() {
//        containerView = UIView(frame: view.bounds)
//        view.addSubview(containerView)
//        
//        containerView.backgroundColor = .systemBackground
//        containerView.alpha = 0
//        // we want to animate the loading instead of just having a jarring appearance.
//        UIView.animate(withDuration: 0.25) { containerView.alpha = 0.8 }
//        
//        let activityIndicator = UIActivityIndicatorView(style: .large)
//        containerView.addSubview(activityIndicator)
//        
//        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//        ])
//        
//        activityIndicator.startAnimating()
//    }
//    
//    
//    func dismissLoadingView() {
//        DispatchQueue.main.async {
//            containerView.removeFromSuperview()
//            containerView = nil
//        }
//    }
//    
//    // moved to data loading view controller subclass
//    func showEmptyStateView(with message: String, in view: UIView) {
//        let emptyStateView = GFEmptyStateView(message: message)
//        emptyStateView.frame = view.bounds
//        view.addSubview(emptyStateView)
//    }
    
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
}
