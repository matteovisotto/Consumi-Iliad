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
    private var dataManager: DataManager!
    private var dataReady: Bool = false
    
    private var isRefreshing: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        headerView.setView(user: Model.shared.user)
        collectionView.delegate = self
        collectionView.dataSource = self
        registerCells()
        
        headerView.addTarget(targer: self, selector: #selector(didTapSettings), for: .touchUpInside)
        
        let refreshControl = UIRefreshControl()
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(requestRefresh), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(Model.shared.soglie != nil){
            dataReady = true
            collectionView.reloadData()
        } else {
            self.dataManager = DataManager(dataType: .soglie)
            dataManager.delegate = self
            dataManager.update()
        }
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
        collectionView.register(LoadingCollectionViewCell.self, forCellWithReuseIdentifier: LoadingCollectionViewCell.cellIdentifier)
        collectionView.register(CreditoCollectionViewCell.self, forCellWithReuseIdentifier: CreditoCollectionViewCell.cellIdentifier)
        collectionView.register(SogliaCollectionViewCell.self, forCellWithReuseIdentifier: SogliaCollectionViewCell.cellIdentifier)
        collectionView.register(ConsumiCollectionViewCell.self, forCellWithReuseIdentifier: ConsumiCollectionViewCell.cellIdentifier)
        collectionView.register(OffertaCollectionViewCell.self, forCellWithReuseIdentifier: OffertaCollectionViewCell.cellIdentifier)
    }
    
    @objc private func didTapRicarica() {
        let ricaricaVC = RicaricaViewController()
        ricaricaVC.modalPresentationStyle = .fullScreen
        self.present(ricaricaVC, animated: true, completion: nil)
    }
    
    @objc private func requestRefresh() {
        
        self.isRefreshing = true
        self.dataManager = DataManager(dataType: .soglie)
        dataManager.delegate = self
        dataManager.update()
    }
    
    private func finishRefresh() {
        self.collectionView.refreshControl?.endRefreshing()
        collectionView.reloadData()
        isRefreshing = false
    }
    
    @objc private func didTapSettings() {
        let settingsVC = SettingsViewController()
        navigationController?.pushViewController(settingsVC, animated: true)
        
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
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(!self.dataReady){
            return 1
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(!dataReady && indexPath.item == 0) {
            return collectionView.dequeueReusableCell(withReuseIdentifier: LoadingCollectionViewCell.cellIdentifier, for: indexPath) as! LoadingCollectionViewCell
        }
        
        if(indexPath.item == 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CreditoCollectionViewCell.cellIdentifier, for: indexPath) as! CreditoCollectionViewCell
            cell.setCell(creditoResiduo: Model.shared.soglie?.credito.residuo ?? "N/A", target: self, selector: #selector(didTapRicarica), forEvent: .touchUpInside)
            return cell
        } else if(indexPath.item == 2){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SogliaCollectionViewCell.cellIdentifier, for: indexPath) as! SogliaCollectionViewCell
            cell.setCell(soglie: Model.shared.soglie!)
            return cell
        }else if(indexPath.item == 1){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OffertaCollectionViewCell.cellIdentifier, for: indexPath) as! OffertaCollectionViewCell
            cell.setCell(perOfferta: Model.shared.offerta)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ConsumiCollectionViewCell.cellIdentifier, for: indexPath) as! ConsumiCollectionViewCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 15, bottom: 15, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.item == 0) {
            return CGSize(width: collectionView.frame.width-30, height: 70)
        } else if(indexPath.item == 1) {
            return CGSize(width: collectionView.frame.width-30, height: 100)
        } else if(indexPath.item == 3) {
            return CGSize(width: collectionView.frame.width-30, height: 70)
        } else {
            return CGSize(width: collectionView.frame.width-30, height: 145)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.item == 3){
            //Consumi
            let consumiVC = ConsumiViewController()
            self.navigationController?.pushViewController(consumiVC, animated: true)
        }
    }
}

extension ViewController: DataManagerDelegate {
    func didFinish(withResult result: Bool, resultMessage: String) {
        if(isRefreshing){
            self.finishRefresh()
        }
        if(result){
            self.dataReady = true
            collectionView.reloadData()
        } else {
            presentErrorAlert(title: "Attenzione", message: resultMessage)
        }
    }
    
    
}

