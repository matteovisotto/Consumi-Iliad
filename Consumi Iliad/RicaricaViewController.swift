//
//  RicaricaViewController.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 01/10/2020.
//

import UIKit
import WebKit

class RicaricaViewController: UIViewController {
    
    private let header = CloseHeaderView()
    private let webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        header.addTarget(target: self, selector: #selector(dismissViewController), for: .touchUpInside)
        let cookies = HTTPCookieStorage.shared.cookies ?? []
        for cookie in cookies {
            webView.configuration.websiteDataStore.httpCookieStore.setCookie(cookie)
        }
        webView.load(URLRequest(url: URL(string: "https://iliad.it/account/")!))
    }
    

    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(header)
        header.translatesAutoresizingMaskIntoConstraints = false
        header.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        header.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        header.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        header.heightAnchor.constraint(equalToConstant: 44).isActive = true
        header.buttonSize = 25
        
        self.view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
        webView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc private func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }

}
