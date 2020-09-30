//
//  CreditoTableViewCell.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 30/09/2020.
//

import UIKit

class CreditoCollectionViewCell: UICollectionViewCell {

    public static let cellIdentifier = "criditoCollectionViewCell"
    
    private let titleLable = UILabel()
    private let credito = UILabel()
    private let ricarica = UIButton()
    
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
        
        self.addSubview(ricarica)
        ricarica.translatesAutoresizingMaskIntoConstraints = false
        ricarica.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        ricarica.heightAnchor.constraint(equalToConstant: 35).isActive = true
        ricarica.backgroundColor = UIColor(named: "primary")!
        ricarica.setTitle("Ricarica", for: .normal)
        ricarica.setTitleColor(.white, for: .normal)
        ricarica.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        ricarica.widthAnchor.constraint(equalToConstant: 100).isActive = true
        ricarica.layer.cornerRadius = 35/2
        
        self.addSubview(titleLable)
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        titleLable.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        titleLable.rightAnchor.constraint(equalTo: ricarica.leftAnchor, constant: -5).isActive = true
        titleLable.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        titleLable.font = .systemFont(ofSize: 14)
        titleLable.text = "Credito residuo"
        
        self.addSubview(credito)
        credito.translatesAutoresizingMaskIntoConstraints = false
        credito.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 5).isActive = true
        credito.rightAnchor.constraint(equalTo: ricarica.leftAnchor, constant: -5).isActive = true
        credito.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        credito.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        credito.font = .boldSystemFont(ofSize: 22)
    }
    
    public func setCell(creditoResiduo: String, target: Any, selector: Selector, forEvent: UIControl.Event) {
        self.credito.text = "\(creditoResiduo) €"
        self.ricarica.addTarget(target, action: selector, for: forEvent)
    }
    
}
