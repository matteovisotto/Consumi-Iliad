//
//  MenuCollectionViewCell.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 02/10/2020.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "menuCollectionViewCell"
    
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet{
            label.textColor = isHighlighted ? UIColor.label : UIColor.secondaryLabel
        }
    }
    
    override var isSelected: Bool {
        didSet{
            label.textColor = isSelected ? UIColor.label : UIColor.secondaryLabel
        }
    }
    
    private func setupUI() {
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 15, weight: .semibold)
    }
    
    public func setMenuCell(withTitle title: String) {
        self.label.text = title
    }
}
