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
        let totalData = try document.select("div.conso__text")[2]
        let totalDataTxt = getTotalInternet(fromString: totalData.ownText()) ?? "0"
        let usedData = try document.select("div#conso-progress").first()!.attr("data-progress-value").replacingOccurrences(of: ",", with: ".")
        let soglia = Soglie(minuti: Minuti(totali: "Illimitati", consumati: ""), sms: Sms(totali: "Illimitati", consumati: ""), internet: Internet(totali: totalDataTxt, consumati: usedData), credito: Credito(residuo: String(creditoResiduo), consumi: ""), rinnovo: getDataRinnovo(fromString: dataRinnovo))
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
    
    private func getTotalInternet(fromString string: String) -> String? {
        let regex = "[0-9]+GB"
        if let range = string.range(of: regex, options: .regularExpression) {
            let str = String(string[range])
            return String(str[str.startIndex..<str.index(str.endIndex, offsetBy: -2)])
        }
        return nil
    }
    
}
