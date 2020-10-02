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
    var residui: String
}

struct Sms {
    var isUnlimited: Bool = true
    var totali: String
    var residui: String
}

struct Internet {
    var isUnlimited: Bool = false
    var totali: String
    var residui: String
}

struct Credito {
    var residuo: String
    var consumi: String
}

class Soglie {
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
    
    init(minuti: Minuti, sms: Sms, internet: Internet, credito: Credito) {
        self.minuti = minuti
        self.sms = sms
        self.internet = internet
        self.credito = credito
    }
    
    
}
