//
//  HomeHeaderView.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 30/09/2020.
//

import UIKit

class HomeHeaderView: UIView {
    
    private let username = UILabel()
    private let phoneNumber = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .systemBackground
        
        
        self.addSubview(username)
        username.translatesAutoresizingMaskIntoConstraints = false
        username.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        username.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        username.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        
        username.font = .boldSystemFont(ofSize: 25)
        
        addSubview(phoneNumber)
        phoneNumber.translatesAutoresizingMaskIntoConstraints = false
        phoneNumber.topAnchor.constraint(equalTo: username.bottomAnchor, constant: 5).isActive = true
        phoneNumber.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        phoneNumber.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        phoneNumber.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        phoneNumber.textColor = .secondaryLabel
    }

    public func setView(user:User) {
        self.phoneNumber.text = user.phoneNumber
        self.username.text = user.username
    }

}
