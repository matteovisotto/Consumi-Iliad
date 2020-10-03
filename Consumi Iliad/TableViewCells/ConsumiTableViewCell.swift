//
//  ConsumiTableViewCell.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 03/10/2020.
//

import UIKit

class ConsumiTableViewCell: UITableViewCell {

    static let cellIdentifier = "consumiTableViewCell"
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupUI()
    }
    
    private func setupUI() {
        self.accessoryType = .none
    }
    
    public func setCell() {
        
    }

}
