//
//  ConsumiViewController.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 02/10/2020.
//

import UIKit

class ConsumiViewController: UIViewController {

    private let header = NavigationHeaderView()
    private let topMenu = TopMenuView()
    
    private let menuItems = ["Chiamate", "Sms", "Internet"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        header.addTarget(target: self, selector: #selector(dismissViewController), for: .touchUpInside)
        header.title = "Consumi"
        topMenu.dataSource = self
        topMenu.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        topMenu.setSelectedIndex(atIndex: 0)
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
        
        self.view.addSubview(topMenu)
        topMenu.translatesAutoresizingMaskIntoConstraints = false
        topMenu.topAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
        topMenu.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        topMenu.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        topMenu.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        
    }

    @objc private func dismissViewController() {
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
}

extension ConsumiViewController: TopMenuDelegate, TopMenuDataSource {
        
    func numberOfItemInMenu(topMenuView: TopMenuView) -> Int {
        return 3
    }
    
    func topMenu(topMenuView: TopMenuView, titleForItemAtIndex itemIndex: Int) -> String {
        return self.menuItems[itemIndex]
    }
    
    func topMenu(topMenuView: TopMenuView, didSelectItemAtIndex itemIdex: Int) {
        print("Selected: \(itemIdex)")
    }
    
}
