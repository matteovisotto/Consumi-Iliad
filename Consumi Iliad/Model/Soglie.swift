//
//  Soglie.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 02/10/2020.
//

import Foundation

struct Minuti {
    var isUnlimited: Bool = true
    var totali: String
    var consumati: String
}

struct Sms {
    var isUnlimited: Bool = true
    var totali: String
    var consumati: String
}

struct Internet {
    var isUnlimited: Bool = false
    var totali: String
    var consumati: String
}

struct Credito {
    var residuo: String
    var consumi: String
}

class Soglie: IliadElement {
    enum Tipo {
        case minuti
        case sms
        case internet
        case credito
    }
    
    var minuti: Minuti!
    var sms: Sms!
    var internet: Internet!
    var credito: Credito!
    var rinnovo: String!
    
    init(minuti: Minuti, sms: Sms, internet: Internet, credito: Credito, rinnovo: String) {
        self.minuti = minuti
        self.sms = sms
        self.internet = internet
        self.credito = credito
        self.rinnovo = rinnovo
    }
    
    override convenience init() {
        self.init(minuti: Minuti(totali: "", consumati: ""), sms: Sms(totali: "", consumati: ""), internet: Internet(totali: "", consumati: ""), credito: Credito(residuo: "", consumi: ""), rinnovo: "N/A")
    }
    
    
}
