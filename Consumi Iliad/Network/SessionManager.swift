//
//  BeePSessionManager.swift
//  BeeP-PoliMi
//
//  Created by Matteo Visotto on 29/02/2020.
//  Copyright © 2020 Matteo Visotto. All rights reserved.
//

import Foundation
import UIKit

class SessionManager {
    
    static let shared = SessionManager()
    var myURLSession: URLSession!
    
    private init () {
        myURLSession = URLSession.shared
    }
    
}
