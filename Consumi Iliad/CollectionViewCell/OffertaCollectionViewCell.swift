//
//  OffertaCollectionViewCell.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 04/10/2020.
//

import UIKit

class OffertaCollectionViewCell: UICollectionViewCell {
    public static let cellIdentifier = "offertaCollectionViewCell"
    
    private let titleLable = UILabel()
    private let titleLable2 = UILabel()
    private let nomeOfferta = UILabel()
    private let costoLabel = UILabel()
    private let prossimoRinnovoLabel = UILabel()
    
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
        titleLable.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        titleLable.heightAnchor.constraint(equalToConstant: 16).isActive = true
        titleLable.font = .systemFont(ofSize: 14)
        titleLable.text = "La mia offerta"
        
        self.addSubview(titleLable2)
        titleLable2.translatesAutoresizingMaskIntoConstraints = false
        titleLable2.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        titleLable2.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        titleLable2.leftAnchor.constraint(equalTo: titleLable.rightAnchor, constant: 5).isActive = true
        titleLable2.heightAnchor.constraint(equalToConstant: 16).isActive = true
        titleLable2.font = .systemFont(ofSize: 14)
        titleLable2.textAlignment = .right
        titleLable2.text = "Costo mensile"
        
        self.addSubview(costoLabel)
        costoLabel.translatesAutoresizingMaskIntoConstraints = false
        costoLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        costoLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        costoLabel.topAnchor.constraint(equalTo: titleLable2.bottomAnchor, constant: 5).isActive = true
        costoLabel.textAlignment = .right
        
        self.addSubview(nomeOfferta)
        nomeOfferta.translatesAutoresizingMaskIntoConstraints = false
        nomeOfferta.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 5).isActive = true
        nomeOfferta.rightAnchor.constraint(equalTo: costoLabel.leftAnchor, constant: -5).isActive = true
        nomeOfferta.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        nomeOfferta.font = .boldSystemFont(ofSize: 22)
        
        self.addSubview(prossimoRinnovoLabel)
        prossimoRinnovoLabel.translatesAutoresizingMaskIntoConstraints = false
        prossimoRinnovoLabel.topAnchor.constraint(equalTo: nomeOfferta.bottomAnchor, constant: 5).isActive = true
        prossimoRinnovoLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        prossimoRinnovoLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        prossimoRinnovoLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        prossimoRinnovoLabel.font = .systemFont(ofSize: 14)
        
        costoLabel.bottomAnchor.constraint(equalTo: prossimoRinnovoLabel.topAnchor, constant: -5).isActive = true
    }
    
    public func setCell(perOfferta offerta: Offerta?, conSoglie soglie: Soglie?) {
        let myOfferta = offerta ?? Offerta()
        let mySoglie = soglie ?? Soglie()
        self.nomeOfferta.text = myOfferta.nome
        self.costoLabel.text = myOfferta.costo + " €/mese"
        self.prossimoRinnovoLabel.text = "Prossimo rinnovo: " + mySoglie.rinnovo
        
    }
}
