//
//  LoadingCollectionViewCell.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 02/10/2020.
//

import UIKit

class LoadingCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "loadingCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let imageView = UIImageView(frame: self.frame)
        let image = UIImage(named: "loading")!
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        imageView.rotate()
        
    }
    
}
