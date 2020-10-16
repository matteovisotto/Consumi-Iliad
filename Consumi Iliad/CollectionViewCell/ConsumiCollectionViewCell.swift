//
//  ConsumiCollectionViewCell.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 02/10/2020.
//

import UIKit

class ConsumiCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "consumiCollectionViewCell"
    
    private let primaryLabel = UILabel()
    private let secondaryLabel = UILabel()
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .systemBackground
        
        self.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.5
        
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 10).isActive = true
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .secondaryLabel
        imageView.contentMode = .scaleAspectFit
        
        self.addSubview(primaryLabel)
        primaryLabel.translatesAutoresizingMaskIntoConstraints = false
        primaryLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        primaryLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        primaryLabel.rightAnchor.constraint(equalTo: imageView.leftAnchor, constant: -5).isActive = true
        primaryLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        
        self.addSubview(secondaryLabel)
        secondaryLabel.translatesAutoresizingMaskIntoConstraints = false
        secondaryLabel.topAnchor.constraint(equalTo: primaryLabel.bottomAnchor, constant: 5).isActive = true
        secondaryLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        secondaryLabel.rightAnchor.constraint(equalTo: imageView.leftAnchor, constant: -5).isActive = true
        secondaryLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        secondaryLabel.textColor = .secondaryLabel
        secondaryLabel.font = .systemFont(ofSize: 14)
    }
    
    func setCell(primaryText: String, secondaryText: String) {
        self.primaryLabel.text = primaryText
        self.secondaryLabel.text = secondaryText
    }
}
