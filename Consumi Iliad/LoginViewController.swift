//
//  LoginViewController.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 29/09/2020.
//

import UIKit
import Alamofire
import SwiftSoup

class LoginViewController: UIViewController {

    let usernameTF = UITextField()
    let passwordTF = UITextField()
    
    let usernameLabel = UILabel()
    let passwordLabel = UILabel()
    
    let loginButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        setupUI()

    }
    
    private func setupUI() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        self.view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        stackView.addArrangedSubview(usernameLabel)
        stackView.addArrangedSubview(usernameTF)
        stackView.addArrangedSubview(passwordLabel)
        stackView.addArrangedSubview(passwordTF)
        
        usernameTF.placeholder = "Codice identificativo"
        passwordTF.placeholder = "Password"
        
        usernameTF.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        
        usernameTF.translatesAutoresizingMaskIntoConstraints = false
        usernameTF.widthAnchor.constraint(equalToConstant: self.view.frame.width-50).isActive = true
        
        self.view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20).isActive = true
        loginButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 15).isActive = true
        loginButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -15).isActive = true
        
        usernameLabel.text = "Codice identificativo"
        
        passwordLabel.text = "Password"
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        loginButton.backgroundColor = .red
        loginButton.layer.cornerRadius = 10
        
        loginButton.addTarget(self, action: #selector(performLogin), for: .touchUpInside)
        
    }
    
    @objc private func performLogin() {
        let postURL = "https://www.iliad.it/account/"
        let parameters = ["login-ident":usernameTF.text!,
                          "login-pwd":passwordTF.text!]
        let downloadTask = DataDownloader(url: postURL, method: .post, parameters: parameters)
        downloadTask.delegate = self
        downloadTask.start()
        
        
    }

}

extension LoginViewController: DataDownloaderDelegate {
    func didDownloadedData(result: Bool, fromUrl: String, withData data: String) {
        print(data)
        do {
            let doc: Document = try SwiftSoup.parse(data)
            let errorDivs: Elements = try doc.select("div")
            let error = errorDivs.hasClass("flash flash-error")
            if(error){
               
            } else {
                
            }
        } catch {
            print("Errore")
        }
    }
    
    
}
