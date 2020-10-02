//
//  SogliaCollectionViewCell.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 30/09/2020.
//

import UIKit

class SogliaCollectionViewCell: UICollectionViewCell {
    public static let cellIdentifier = "sogliaCollectionViewCell"
    
    private let titleLable = UILabel()
    private let stackView = UIStackView()
    
    private let minuti = SogliaView()
    private let sms = SogliaView()
    private let internet = SogliaView()
    
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
        
        self.addSubview(titleLable)
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        titleLable.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        titleLable.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        titleLable.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        titleLable.font = .systemFont(ofSize: 14)
        titleLable.text = "Le mie soglie"
        
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 10).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        stackView.axis = .horizontal
        stackView.spacing = 3
        stackView.distribution = .fillEqually
        
        stackView.addArrangedSubview(minuti)
        stackView.addArrangedSubview(sms)
        stackView.addArrangedSubview(internet)
        
        
        
    }
    
    public func setCell(soglie: Soglie) {
        minuti.setView(percentage: 1, image: UIImage(systemName: "phone")!, text: "Illimitati")
        sms.setView(percentage: 1, image: UIImage(systemName: "envelope")!, text: "Illimitati")
        internet.setView(percentage: 50, image: UIImage(systemName: "globe")!, text: "25GB / 50GB")
    }
    
   
}
