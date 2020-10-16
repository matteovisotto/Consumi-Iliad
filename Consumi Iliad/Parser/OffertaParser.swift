//
//  OffertaParser.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 04/10/2020.
//

import UIKit

class OffertaParser: Parser {
    
    override init(dataString: String) throws {
        try super.init(dataString: dataString)
    }
    
    override public func parse() throws -> IliadElement {
        let nomeOfferta = try document.select("div.title > span.red").first()!
        let nameString = String(nomeOfferta.ownText())
        return Offerta(nome: getName(fromString: nameString), costo: getCosto(fromString: nameString))
    }
    
    private func getName(fromString str: String) -> String {
        let lastSpaceIndex = str.lastIndex(of: " ") ?? str.endIndex
        let nomeStr = String(str[str.startIndex..<lastSpaceIndex])
        let firstSpaceIndex = str.firstIndex(of: " ") ?? str.startIndex
        return String(nomeStr[nomeStr.index(firstSpaceIndex, offsetBy: 1)..<nomeStr.endIndex]).capitalized
    }
    
    private func getCosto(fromString str: String) -> String {
        let lastSpaceIndex = str.lastIndex(of: " ") ?? str.endIndex
        let costoStr = String(str[lastSpaceIndex..<str.endIndex]).trimmingCharacters(in: .whitespacesAndNewlines)
        return String(costoStr.dropLast())
    }
}


extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
