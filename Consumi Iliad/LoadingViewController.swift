//
//  LoadingViewController.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 29/09/2020.
//

import UIKit
import SwiftSoup

class LoadingViewController: UIViewController {

    private let appLogo = UIImageView()
    private let statusLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userDefaults = UserDefaults.standard
        let username = userDefaults.string(forKey: "username") ?? String()
        let password = userDefaults.string(forKey: "password") ?? String()
        
        if(username.isEmpty || password.isEmpty) {
            showLogin()
        } else {
            setupUI()
            doLogin(username: username, password: password)
        }
    }
    
    private func setupUI() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.addArrangedSubview(appLogo)
        stackView.addArrangedSubview(statusLabel)
        self.view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        appLogo.translatesAutoresizingMaskIntoConstraints = false
        appLogo.widthAnchor.constraint(equalToConstant: 150).isActive = true
        appLogo.heightAnchor.constraint(equalToConstant: 150).isActive = true
        statusLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        statusLabel.textAlignment = .center
        appLogo.backgroundColor = .clear
        appLogo.image = UIImage(named: "appIcon")
        appLogo.contentMode = .scaleAspectFit
        statusLabel.text = "Caricamento dati in corso"
    }

    private func showLogin() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let sceneDelegate = windowScene.delegate as? SceneDelegate
        else {
          return
        }
        let rootViewController = LoginViewController()
        sceneDelegate.window?.rootViewController = rootViewController
    }

    private func doLogin(username: String, password: String) {
        let postURL = "https://www.iliad.it/account/"
        let parameters = ["login-ident":username,
                          "login-pwd":password]
        let downloadTask = DataDownloader(url: postURL, method: .post, parameters: parameters)
        downloadTask.delegate = self
        downloadTask.start()
    }
    
    private func presentErrorAlert(title: String, message: String) {
        let errorAlert = ErrorAlertController()
        errorAlert.providesPresentationContextTransitionStyle = true
        errorAlert.definesPresentationContext = true
        errorAlert.modalPresentationStyle = .overFullScreen
        errorAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        errorAlert.setAlert(title: title, message: message)
        self.present(errorAlert, animated: true, completion: nil)
    }
    
    private func switchViewController() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let sceneDelegate = windowScene.delegate as? SceneDelegate
        else {
          return
        }
        let rootViewController = UINavigationController(rootViewController: ViewController())
        rootViewController.navigationBar.isHidden = true
        sceneDelegate.window?.rootViewController = rootViewController
    }
}

extension LoadingViewController: DataDownloaderDelegate {
    func didDownloadedData(result: Bool, fromUrl: String, withData data: String) {
        if(!result) {
            DispatchQueue.main.async {
                self.presentErrorAlert(title: "Attenzione", message: "Si è verificato un errore nella comunicazione con il server: \(data)")
            }
        }
        
        do {
            let doc: Document = try SwiftSoup.parse(data)
            let divs: Elements = try doc.select("div")
            let error = divs.hasClass("flash flash-error")
            
            if(error){
                for div in divs {
                    if(try div.className() == "flash flash-error"){
                        let message = try div.text().dropLast()
                        DispatchQueue.main.async {
                            self.presentErrorAlert(title: "Attenzione", message: String(message))
                        }
                        return
                    }
                }
            } else {
                //Login has been successfully completed
                let userDiv = try doc.select("div.current-user__infos > div.bold").first()
                let numberDiv = try doc.select("div.current-user__infos > div.smaller").last()
                
                let numberString = numberDiv?.ownText() ?? ""
                let number = numberString.filter("0123456789.".contains)
                
                let username = userDiv?.ownText() ?? ""
                
                Model.shared.user = User(username: username, phoneNumber: number)
                
                DispatchQueue.main.async {
                    self.switchViewController()
                }
            }
        } catch {
            DispatchQueue.main.async {
                self.presentErrorAlert(title: "Attenzione", message: "Si è verificato un errore con la risposta fornita dal server")
            }
        }
    }
    
    
}
