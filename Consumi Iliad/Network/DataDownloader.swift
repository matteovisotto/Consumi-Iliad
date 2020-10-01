//
//  DataDownloader.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 29/09/2020.
//

import Foundation
import UIKit

enum RequestMethod: String {
    case post = "POST"
    case get = "GET"
}

protocol DataDownloaderDelegate {
    func didDownloadedData(result: Bool, fromUrl: String, withData data: String)
}

class DataDownloader {
    var delegate: DataDownloaderDelegate? = nil
    let session = SessionManager.shared.myURLSession
    var downloadURL: String!
    var myMethod:RequestMethod = .get
    var parameters: [String:String]? = nil
    
    init(url: String, method: RequestMethod = .get, parameters: [String:String]? = nil) {
        self.downloadURL = url
        self.myMethod = method
        self.parameters = parameters
    }
    
    open func start() {
        let myURL = URL(string: self.downloadURL)!
        var myRequest = URLRequest(url: myURL)
        myRequest.allowsCellularAccess = true
        myRequest.httpMethod = myMethod.rawValue
        myRequest.setValue("keep-alive", forHTTPHeaderField: "Connection")
        
        if(parameters != nil && myMethod == .post) {
            myRequest.httpBody = parameters?.percentEncoded()
        }
        
        let dataTask = self.session?.dataTask(with: myRequest) { (data, response, error) in
            let statusCode = (response as! HTTPURLResponse).statusCode
            if(error != nil) {
                self.delegate?.didDownloadedData(result: false, fromUrl: "", withData: String(statusCode))
            }
            if(statusCode == 200) {
                self.delegate?.didDownloadedData(result: true, fromUrl: self.downloadURL, withData: String(data: data!, encoding: .utf8) ?? "")
                
            }
        }
        
        dataTask?.resume()
    }
    
}

extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
