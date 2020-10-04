//
//  SoglieParser.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 01/10/2020.
//

import Foundation
import UIKit
import SwiftSoup

class SoglieParser: Parser {
   
    override init(dataString: String) throws {
        try super.init(dataString: dataString)
    }
    
    override func parse() throws -> IliadElement {
        let soglia = Soglie(minuti: Minuti(totali: "", residui: ""), sms: Sms(totali: "", residui: ""), internet: Internet(totali: "", residui: ""), credito: Credito(residuo: "", consumi: ""))
        return soglia
    }
    
}
