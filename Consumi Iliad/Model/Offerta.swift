//
//  File.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 04/10/2020.
//

import Foundation

class Offerta {
    
    var nome: String!
    var costo: String!
    var rinnovo: String!
    
    init() {
        self.nome = "N/A"
        self.costo = "N/A"
        self.rinnovo = "N/A"
    }
    
    init(nome: String, costo: String, rinnovo: String) {
        self.nome = nome
        self.costo = costo
        self.rinnovo = rinnovo
    }
    
}
