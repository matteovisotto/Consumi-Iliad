//
//  File.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 04/10/2020.
//

import Foundation

class Offerta: IliadElement {
    
    var nome: String!
    var costo: String!
    
    override init() {
        super.init()
        
        self.nome = "N/A"
        self.costo = "N/A"
    }
    
    init(nome: String, costo: String) {
        self.nome = nome
        self.costo = costo
    }
    
}
