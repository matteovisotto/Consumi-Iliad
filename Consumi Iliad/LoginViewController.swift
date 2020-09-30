//
//  LoginViewController.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 29/09/2020.
//

import UIKit
import SwiftSoup

class LoginViewController: UIViewController {

    private let usernameTF = UITextField()
    private let passwordTF = UITextField()
    private let logo = UIImageView()
    private let infoLabel = UILabel()
    
    private let loginButton = UIButton()
    
    private var loadingAlert:LoadingAlert? = nil
    
    private let textFieldHeight: CGFloat = 40
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let sfondo = UIImageView(frame: self.view.frame)
        sfondo.image = UIImage(named: "sfondo")!
        sfondo.contentMode = .scaleAspectFill
        self.view.addSubview(sfondo)
       
        setupUI()

    }
    
    private func setupUI() {
        let containerView = UIView()
        self.view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: self.view.frame.width-40).isActive = true
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 10
        containerView.backgroundColor = .systemBackground
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        containerView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        stackView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10).isActive = true
        stackView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10).isActive = true
        
        let usernameView = createTFView(for: usernameTF, withImageIcon: UIImage(named: "user")!, height: self.textFieldHeight)
        let passwordView = createTFView(for: passwordTF, withImageIcon: UIImage(named: "password")!, height: self.textFieldHeight)
       
        stackView.addArrangedSubview(logo)
        stackView.addArrangedSubview(infoLabel)
        stackView.addArrangedSubview(usernameView)
        stackView.addArrangedSubview(passwordView)
        
        infoLabel.text = "Inserisci i dati del tuo account Iliad"
        infoLabel.textAlignment = .center
        
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.heightAnchor.constraint(equalToConstant: 90).isActive = true
        logo.image = UIImage(named: "appLogo")!
        logo.contentMode = .scaleAspectFit
        logo.tintColor = UIColor(named: "primary")!
        
        usernameView.translatesAutoresizingMaskIntoConstraints = false
        usernameView.heightAnchor.constraint(equalToConstant: self.textFieldHeight).isActive = true
        
        passwordView.translatesAutoresizingMaskIntoConstraints = false
        passwordView.heightAnchor.constraint(equalToConstant: self.textFieldHeight).isActive = true
        
        usernameTF.placeholder = "Codice identificativo"
        passwordTF.placeholder = "Password"
        
        
        containerView.addSubview(loginButton)
        let loginButtonDimen = 40
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20).isActive = true
        loginButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10).isActive = true
        loginButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: CGFloat(loginButtonDimen)).isActive=true
        
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        loginButton.backgroundColor = UIColor(named: "primary")!
        loginButton.layer.cornerRadius = CGFloat(loginButtonDimen/2)
        
        loginButton.addTarget(self, action: #selector(performLogin), for: .touchUpInside)
        
    }
    
    private func createTFView(for textField: UITextField, withImageIcon icon: UIImage, height: CGFloat) -> UIView {
        let view = UIView()
        let imageView = UIImageView()
        view.addSubview(imageView)
        view.addSubview(textField)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: height-16).isActive = true
        imageView.image = icon
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .label
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 10).isActive = true
        textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
        textField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -height/2).isActive = true
        textField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
        
        view.layer.cornerRadius = height/2
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        return view
    }
    
    @objc private func performLogin() {
        
        loadingAlert = LoadingAlert(frame: self.view.frame)
        loadingAlert!.activityMessage = "Login in corso..."
        loadingAlert!.present(in: self)
        
        let postURL = "https://www.iliad.it/account/"
        let parameters = ["login-ident":usernameTF.text!,
                          "login-pwd":passwordTF.text!]
        let downloadTask = DataDownloader(url: postURL, method: .post, parameters: parameters)
        downloadTask.delegate = self
        downloadTask.start()
        
        
    }
    
    private func switchViewController() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let sceneDelegate = windowScene.delegate as? SceneDelegate
        else {
          return
        }
        let rootViewController = ViewController()
        sceneDelegate.window?.rootViewController = rootViewController
    }
    
}

extension LoginViewController: DataDownloaderDelegate {
    func didDownloadedData(result: Bool, fromUrl: String, withData data: String) {
        print(data)
        DispatchQueue.main.async {
            self.loadingAlert?.remove()
        }
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
