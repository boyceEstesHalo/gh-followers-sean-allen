//
//  SearchVC.swift
//  GHFollowers
//
//  Created by Boyce Estes on 7/1/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    // nice organization is to order where they are on the screen
    let logoImageView = UIImageView()
    let usernameTextField = GFTextField()
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    
    var isUsernameEntered: Bool {
        !usernameTextField.text!.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // this adjusts for darkmode
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardTapGesture()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // navigation bar looks kindof strange so we want to hide it when this appears
        usernameTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    @objc func pushFollowerListVC() {
        guard isUsernameEntered else {
            presentGFAlertOnMainThread(title: "Empty Username", message: "Please enter a username. We need to know who to look for 👀", buttonTitle: "I'll do my best")
            return
        }
        
        usernameTextField.resignFirstResponder()
        
        let followerListVC = FollowerListVC(username: usernameTextField.text!)
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        // Insteady of stringly typing something - it should be a constant.
        logoImageView.image = Images.ghLogo
        
        // this is a tweak to make the textfield appear above the keyboard - you don't want to hardcode things like this too much
        // if apple changes something in the UI in the future, this could look very bad
        let topConstraintConstant: CGFloat = DeviceType.isiPhoneSE || DeviceType.isiPhone8Zoomed ? 20 : 80
        
        // Rule of thumb - 4 constraints per object
        // setting constraints in array is a better method of activating constraints instead of setting each .active = true
        NSLayoutConstraint.activate([
            // we need to use safeAreaLayoutGuide to account for the notch. If we were doing
            // a landscape project, we would constraint to this anchor when measuring from the edge as well
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    func configureTextField() {
        view.addSubview(usernameTextField)
        usernameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            // buttons and text fields need to be at least 44 height
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func configureCallToActionButton() {
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}


extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}
