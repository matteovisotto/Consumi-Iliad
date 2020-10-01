//
//  SettingsTableViewHeader.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 01/10/2020.
//

import UIKit

class SettingsTableViewHeader: UIView {
    
    private let imageView = UIImageView()
    private let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        self.backgroundColor = .clear
        self.addSubview(imageView)
        self.addSubview(label)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5).isActive = true
        label.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10 ).isActive = true
        
        label.heightAnchor.constraint(equalToConstant: 25).isActive = true
        label.font = .boldSystemFont(ofSize: 15)
        label.text = "Consumi Iliad"
        label.textAlignment = .center
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "appIcon")!
    }
}

