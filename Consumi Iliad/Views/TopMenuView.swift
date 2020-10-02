//
//  TopMenuView.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 02/10/2020.
//

import UIKit

protocol TopMenuDataSource {
    func numberOfItemInMenu(topMenuView: TopMenuView) -> Int
    func topMenu(topMenuView: TopMenuView, titleForItemAtIndex itemIndex: Int) -> String
}

protocol TopMenuDelegate {
    func topMenu(topMenuView: TopMenuView, didSelectItemAtIndex itemIdex: Int)
}

class TopMenuView: UIView {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    private var numberOfItem: Int = 0
    
    open var dataSource: TopMenuDataSource? = nil
    open var delegate: TopMenuDelegate? = nil
    
    private var horizontalBarLeftConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .systemBackground
        
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.cellIdentifier)
        
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = .label
        addSubview(horizontalBarView)
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        horizontalBarLeftConstraint = horizontalBarView.leftAnchor.constraint(equalTo: leftAnchor)
        horizontalBarLeftConstraint?.isActive = true
        horizontalBarView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        horizontalBarView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/3).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 3).isActive = true
    }
    
    public func setSelectedIndex(atIndex index: Int){
        collectionView.selectItem(at: IndexPath(item: index, section: 0), animated: false, scrollPosition: [])
        self.delegate?.topMenu(topMenuView: self, didSelectItemAtIndex: index)
    }
    
}

extension TopMenuView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.numberOfItem = self.dataSource?.numberOfItemInMenu(topMenuView: self) ?? 0
        return numberOfItem
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.cellIdentifier, for: indexPath) as! MenuCollectionViewCell
        cell.setMenuCell(withTitle: self.dataSource?.topMenu(topMenuView: self, titleForItemAtIndex: indexPath.item) ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width/CGFloat(numberOfItem), height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let x = CGFloat(indexPath.item) * frame.width/CGFloat(numberOfItem)
        horizontalBarLeftConstraint?.constant = x
        self.delegate?.topMenu(topMenuView: self, didSelectItemAtIndex: indexPath.item)
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
        
    }
    
}
