//
//  SogliaView.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 02/10/2020.
//

import Foundation
import UIKit

class SogliaView: UIView {
    var contatore = Contatore()
    let label = UILabel()
    
    var percentage: CGFloat = 0
    var image: UIImage = UIImage()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupUI()
    }
    
    private func setupUI() {
        let size = min(bounds.size.height * 4/5, bounds.size.width-4)
        self.addSubview(contatore)
        contatore.translatesAutoresizingMaskIntoConstraints = false
        contatore.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contatore.widthAnchor.constraint(equalToConstant: size).isActive = true
        contatore.heightAnchor.constraint(equalToConstant: size).isActive = true
        contatore.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        contatore.layoutIfNeeded()
        
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: contatore.bottomAnchor, constant: 2).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        
    }
    
    func setView(percentage: CGFloat, image: UIImage, text: String){
        self.label.text = text
        self.image = image
        self.percentage = percentage
        contatore.dataSource = self
    }
    
}

extension SogliaView: ContatoreDataSource {
    func fillPercentage() -> CGFloat {
        return percentage
    }
    
    func iconForChart() -> UIImage {
        return image
    }
    
    func animateLoading() -> Bool {
        return true
    }
    
    
}
