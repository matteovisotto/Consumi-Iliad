//
//  Parser.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 01/10/2020.
//

import Foundation
import UIKit
import SwiftSoup

struct WebError {
    var isError: Bool
    var errorMessage: String
}

class Parser {
    //MARK:- Static class fuctions
    class func isLoginError(data: String) throws -> WebError{
        let doc: Document = try SwiftSoup.parse(data)
        let errorDivs: Elements = try doc.select("div")
        let error = errorDivs.hasClass("flash flash-error")
        
        if(error){
            for div in errorDivs {
                if(try div.className() == "flash flash-error"){
                    let message = try div.text().dropLast()
                    return WebError(isError: true, errorMessage: String(message))
                }
            }
        }
    
        return WebError(isError: false, errorMessage: "")
        
    }
    
    //MARK:- Instance class function
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
