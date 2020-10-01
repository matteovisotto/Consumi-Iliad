//
//  NavigationHeaderView.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 01/10/2020.
//

import UIKit

class NavigationHeaderView: UIView {
    
    fileprivate let backButton = UIButton()
    fileprivate let titleLabel = UILabel()
    open var buttonSize: CGFloat = 25
    
    open var title: String = "" {
        didSet{
            self.titleLabel.text = title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .systemBackground
        
        self.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        backButton.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        backButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: self.buttonSize).isActive = true
        backButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        backButton.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.tintColor = .label
        
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: backButton.rightAnchor, constant: 5).isActive = true
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
    }
    
    public func addTarget(target: Any?, selector: Selector, for controlEvent: UIControl.Event){
        self.backButton.addTarget(target, action: selector, for: controlEvent)
    }
    
}
