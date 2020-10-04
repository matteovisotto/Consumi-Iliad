//
//  HomeCollectionReusableView.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 04/10/2020.
//

import UIKit

class HomeFooterCollectionReusableView: UICollectionReusableView {
    
    static let viewIdentifier = "homeCollectionReusableView"
    
    let footerLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        footerLabel.textAlignment = .center
        footerLabel.numberOfLines = .zero
        footerLabel.font = .systemFont(ofSize: 12)
        addSubview(footerLabel)
        footerLabel.translatesAutoresizingMaskIntoConstraints = false
        footerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        footerLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        footerLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
        footerLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        footerLabel.textColor = .secondaryLabel
    }
}
