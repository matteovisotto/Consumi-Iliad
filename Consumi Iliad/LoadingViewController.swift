//
//  LoadingViewController.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 29/09/2020.
//

import UIKit

class LoadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        doLogin()
    }
    

    private func doLogin() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let sceneDelegate = windowScene.delegate as? SceneDelegate
        else {
          return
        }
        let rootViewController = LoginViewController()
        sceneDelegate.window?.rootViewController = rootViewController
    }

}
