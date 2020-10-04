//
//  Model.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 01/10/2020.
//

import Foundation

struct Login {
    var username: String
    var password: String
}

class Model {
    public static let shared: Model = Model()
    
    private init() {}
    
    open var user: User = User()
    
    open var login: Login = Login(username: "", password: "")
    
    open var soglie: Soglie? = nil
    
    open var offerta: Offerta? = nil
    
    
    
}
