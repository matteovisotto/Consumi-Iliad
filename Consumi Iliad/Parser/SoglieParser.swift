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
        let creditoResiduo = try document.select("b.red").first()!.ownText().dropLast()
        let dataRinnovo = try document.select("div.end_offerta").first()!.ownText()
        let soglia = Soglie(minuti: Minuti(totali: "", residui: ""), sms: Sms(totali: "", residui: ""), internet: Internet(totali: "", residui: ""), credito: Credito(residuo: String(creditoResiduo), consumi: ""), rinnovo: getDataRinnovo(fromString: dataRinnovo))
        return soglia
    }
    
       
    private func getDataRinnovo(fromString str: String) -> String {
        let regex = "[0-9]{2}/[0-9]{2}/[0-9]{4}"
        if let range = str.range(of: regex, options: .regularExpression){
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            formatter.locale = Calendar.current.locale
            formatter.timeZone = Calendar.current.timeZone
            let date = formatter.date(from: String(str[range])) ?? Date()
            let next = "\(date.get(.day))/\(date.get(.month))/\(date.get(.year))"
            return next
        }
        return "N/A"
    }
    
}
