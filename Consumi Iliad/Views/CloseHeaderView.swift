//
//  CloseHeaderView.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 01/10/2020.
//

import UIKit

class CloseHeaderView: UIView {
    
    fileprivate let closeButton = UIButton()
    open var buttonSize: CGFloat = 25
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .systemBackground
        
        self.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        closeButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: self.buttonSize).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: self.buttonSize).isActive = true
        closeButton.setBackgroundImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.imageView?.contentMode = .scaleAspectFit
        closeButton.tintColor = .label
    }
    
    public func addTarget(target: Any?, selector: Selector, for controlEvent: UIControl.Event){
        self.closeButton.addTarget(target, action: selector, for: controlEvent)
    }
    
}
