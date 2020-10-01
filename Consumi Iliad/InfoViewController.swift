//
//  InfoViewController.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 01/10/2020.
//

import UIKit

class InfoViewController: UIViewController {
    
    let header = NavigationHeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        header.title = "Informazioni"
        header.addTarget(target: self, selector: #selector(dismissViewController), for: .touchUpInside)
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
    }

    @objc private func dismissViewController() {
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
}
