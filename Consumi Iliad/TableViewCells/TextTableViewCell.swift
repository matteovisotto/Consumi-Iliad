//
//  TextTableViewCell.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 01/10/2020.
//

import UIKit

class TextTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "textTableViewCell"

    let label = UILabel()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupUI()
    }
    
    private func setupUI(){
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
    }
    
    func setCell(cellDescription: String, accessoryType: UITableViewCell.AccessoryType) {
        self.label.text = cellDescription
        self.accessoryType = accessoryType
    }
}
