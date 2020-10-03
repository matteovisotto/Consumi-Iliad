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
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    private let menuItems = ["Chiamate", "Sms", "Internet", "Altro"]
    private var selectedMenuIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        header.addTarget(target: self, selector: #selector(dismissViewController), for: .touchUpInside)
        header.title = "Consumi"
        topMenu.dataSource = self
        topMenu.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ConsumiTableViewCell.self, forCellReuseIdentifier: ConsumiTableViewCell.cellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        topMenu.setSelectedIndex(atIndex: selectedMenuIndex)
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
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: topMenu.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        
        tableView.tableFooterView = createFooterView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
        
    }
    
    private func createFooterView(frame: CGRect) -> UIView {
        let footerView = UIView(frame: frame)
        let footerLabel = UILabel(frame: CGRect(x: 5, y: 0, width: self.view.frame.width, height: 40))
        footerLabel.text = "Per visualizzare i consumi effettuati nei mesi precedenti accedere all'area personale dal sito Iliad"
        footerLabel.textAlignment = .center
        footerLabel.numberOfLines = .zero
        footerLabel.font = .systemFont(ofSize: 12)
        footerView.addSubview(footerLabel)
        footerLabel.translatesAutoresizingMaskIntoConstraints = false
        footerLabel.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 5).isActive = true
        footerLabel.leftAnchor.constraint(equalTo: footerView.leftAnchor, constant: 5).isActive = true
        footerLabel.rightAnchor.constraint(equalTo: footerView.rightAnchor, constant: -5).isActive = true
        footerLabel.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: -5).isActive = true
        
        return footerView
    }

    @objc private func dismissViewController() {
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.dismiss(animated: true, completion: nil)
    }
}

extension ConsumiViewController: TopMenuDelegate, TopMenuDataSource {
        
    func numberOfItemInMenu(topMenuView: TopMenuView) -> Int {
        return 4
    }
    
    func topMenu(topMenuView: TopMenuView, titleForItemAtIndex itemIndex: Int) -> String {
        return self.menuItems[itemIndex]
    }
    
    func topMenu(topMenuView: TopMenuView, didSelectItemAtIndex itemIdex: Int) {
        self.selectedMenuIndex = itemIdex
        self.tableView.reloadData()
    }
    
}

extension ConsumiViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.selectedMenuIndex == 0){
            
        } else if(selectedMenuIndex == 1){
            
        } else if(selectedMenuIndex == 2) {
            
        } else if(selectedMenuIndex == 3) {
            
        }
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConsumiTableViewCell.cellIdentifier) as! ConsumiTableViewCell
        
        if(self.selectedMenuIndex == 0){
            
        } else if(selectedMenuIndex == 1){
            
        } else if(selectedMenuIndex == 2) {
            
        } else if(selectedMenuIndex == 3) {
            
        }
        
        return cell
    }
}
