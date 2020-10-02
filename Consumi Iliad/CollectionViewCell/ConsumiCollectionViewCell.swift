//
//  ConsumiCollectionViewCell.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 02/10/2020.
//

import UIKit

class ConsumiCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "consumiCollectionViewCell"
    
    
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
    }
}
