//
//  IliadElement.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 04/10/2020.
//

import Foundation

class IliadElement {
    var updatedAt: Date!
    
    init() {
        self.updatedAt = Date()
    }
    
    public func lastDataUpdate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy - HH:mm:ss"
        formatter.locale = Calendar.current.locale
        formatter.timeZone = Calendar.current.timeZone
        return formatter.string(from: self.updatedAt)
    }
    
}
