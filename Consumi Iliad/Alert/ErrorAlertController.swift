//
//  ErrorAlertController.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 30/09/2020.
//

import UIKit

class ErrorAlertController: UIViewController {
    
    private let container = UIView()
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        setupUI()
    }
    

    private func setupUI() {
        self.view.addSubview(container)
        container.layer.cornerRadius = 10
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .systemBackground
        container.widthAnchor.constraint(equalToConstant: self.view.frame.width-60).isActive = true
        container.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        container.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        container.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 10).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -10).isActive = true
        titleLabel.font = .systemFont(ofSize: 20, weight: .heavy)
        titleLabel.textAlignment = .center
        
        container.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 10).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -10).isActive = true
        messageLabel.numberOfLines = .zero
        
        container.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 15).isActive = true
        button.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 10).isActive = true
        button.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -10).isActive = true
        button.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10).isActive = true
        button.setTitle("OK", for: .normal)
        button.setTitleColor(UIColor(named: "primary")!, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        
    }
    
    @objc private func dismissAlert() {
        self.dismiss(animated: true, completion: nil)
    }
    
    public func setAlert(title: String, message: String) {
        self.titleLabel.text = title
        self.messageLabel.text = message
    }
}
