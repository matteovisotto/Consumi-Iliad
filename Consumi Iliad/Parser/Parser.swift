//
//  Parser.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 01/10/2020.
//

import Foundation
import UIKit
import SwiftSoup

class Parser {
    open var document: Document!
    
    init(dataString: String) throws {
        document = try SwiftSoup.parse(dataString)
    }
    
    public func getUser() throws -> User {
        let userDiv = try document.select("div.current-user__infos > div.bold").first()
        let numberDiv = try document.select("div.current-user__infos > div.smaller").last()
        let numberString = numberDiv?.ownText() ?? ""
        let number = numberString.filter("0123456789.".contains)
        let username = userDiv?.ownText() ?? ""
        return User(username: username, phoneNumber: number)
    }
}
