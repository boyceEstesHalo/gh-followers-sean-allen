//
//  GFAlertVC.swift
//  GHFollowers
//
//  Created by Boyce Estes on 7/15/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import UIKit

class GFAlertVC: UIViewController {

    let containerView = GFCustomContainerView()
    let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let bodyLabel = GFBodyLabel(textAlignment: .center)
    let actionButton = GFButton(backgroundColor: .systemPink, title: "Ok")

    var alertTitle: String?
    var message: String?
    var buttonTitle: String?

    let padding: CGFloat = 20


    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        addSubviews()
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureBodyLabel()
    }

    
    func addSubviews() {
        view.addSubview(containerView)
        containerView.addSubviews(titleLabel, actionButton, bodyLabel)
    }


    func configureContainerView() {
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 300),
            // Ideally your height should dynamically shift to fit the body content,
            // but it should always be relatively short.
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }


    func configureTitleLabel() {
        titleLabel.text = alertTitle ?? "Something went wrong"

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }

    // pin the button to the bottom - this way we can have the body just be filling the rest
    // of the space
    func configureActionButton() {
        actionButton.setTitle(buttonTitle ?? "OK", for: .normal)
        // what does the button need to do?
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)

        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 50.0)
        ])
    }

    func configureBodyLabel() {
        bodyLabel.text = message ?? "Unable to complete request"
        bodyLabel.numberOfLines = 4

        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            bodyLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            bodyLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            bodyLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -8)
        ])
    }

    @objc func dismissVC() {
        dismiss(animated: true)
    }
}

