//
//  ViewController.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 29/09/2020.
//

import UIKit

class ViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var headerView = HomeHeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        headerView.setView(username: "Matteo Visotto", phoneNumber: "3485659652")
        collectionView.delegate = self
        collectionView.dataSource = self
        registerCells()
        collectionView.reloadData()
        
        let refreshControl = UIRefreshControl()
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(requestRefresh), for: .valueChanged)
    }
    
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        headerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        headerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.systemBackground
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    private func registerCells() {
        collectionView.register(CreditoCollectionViewCell.self, forCellWithReuseIdentifier: CreditoCollectionViewCell.cellIdentifier)
        collectionView.register(SogliaCollectionViewCell.self, forCellWithReuseIdentifier: SogliaCollectionViewCell.cellIdentifier)
    }
    
    @objc private func didTapRicarica() {
        print("Did tap ricarica")
    }
    
    @objc private func requestRefresh() {
        self.collectionView.refreshControl?.endRefreshing()
        collectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.item == 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CreditoCollectionViewCell.cellIdentifier, for: indexPath) as! CreditoCollectionViewCell
            cell.setCell(creditoResiduo: "19,45", target: self, selector: #selector(didTapRicarica), forEvent: .touchUpInside)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SogliaCollectionViewCell.cellIdentifier, for: indexPath) as! SogliaCollectionViewCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 15, bottom: 15, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.item == 0) {
            return CGSize(width: collectionView.frame.width-30, height: 70)
        } else {
            return CGSize(width: collectionView.frame.width-30, height: 140)
        }
    }
}


