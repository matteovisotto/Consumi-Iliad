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
    private let settingsButton = UIButton()
    
    open var buttonSize: CGFloat = 25
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .systemBackground
        
        self.addSubview(settingsButton)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        settingsButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        settingsButton.widthAnchor.constraint(equalToConstant: self.buttonSize).isActive = true
        settingsButton.heightAnchor.constraint(equalToConstant: self.buttonSize).isActive = true
        settingsButton.setImage(UIImage(systemName: "gear"), for: .normal)
        settingsButton.imageView?.contentMode = .scaleAspectFit
        settingsButton.tintColor = .label
        
        self.addSubview(username)
        username.translatesAutoresizingMaskIntoConstraints = false
        username.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        username.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        username.rightAnchor.constraint(equalTo: settingsButton.leftAnchor, constant: -5).isActive = true
        
        username.font = .boldSystemFont(ofSize: 25)
        
        addSubview(phoneNumber)
        phoneNumber.translatesAutoresizingMaskIntoConstraints = false
        phoneNumber.topAnchor.constraint(equalTo: username.bottomAnchor, constant: 5).isActive = true
        phoneNumber.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        phoneNumber.rightAnchor.constraint(equalTo: settingsButton.leftAnchor, constant: -5).isActive = true
        phoneNumber.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        phoneNumber.textColor = .secondaryLabel
    }

    public func setView(user:User) {
        self.phoneNumber.text = user.phoneNumber
        self.username.text = user.username
    }
    
    public func addTarget(targer: Any?, selector: Selector, for controlEvent: UIControl.Event) {
        self.settingsButton.addTarget(targer, action: selector, for: controlEvent)
    }

}
