//
//  NotificationViewController.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 30/09/2020.
//

import UIKit

class LoadingAlert: UIView {
    
    open var activityMessage: String = "" {
        didSet {
            self.label.text = activityMessage
        }
    }
    
    private var isDarkMode: Bool = false
    
    private let activityIndicator = UIActivityIndicatorView()
    private var backGroundView: UIVisualEffectView!
    private let label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isDarkMode = self.traitCollection.userInterfaceStyle == .dark
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    
    private func setupUI() {
        
        backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        
        backGroundView = UIVisualEffectView(effect: UIBlurEffect(style: isDarkMode ? .light : .dark))
        addSubview(backGroundView)
        backGroundView.translatesAutoresizingMaskIntoConstraints = false
        backGroundView.widthAnchor.constraint(equalToConstant: frame.width - 70).isActive = true
        backGroundView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        backGroundView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        backGroundView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        backGroundView.layer.masksToBounds = true
        backGroundView.layer.cornerRadius = 10
        
        
        backGroundView.contentView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.leftAnchor.constraint(equalTo: backGroundView.leftAnchor, constant: 10).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: backGroundView.centerYAnchor).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 30).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 30).isActive = true
        activityIndicator.color = isDarkMode ? .black : .white
        
        backGroundView.contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.rightAnchor.constraint(equalTo: backGroundView.rightAnchor, constant: -10).isActive = true
        label.leftAnchor.constraint(equalTo: activityIndicator.rightAnchor, constant: 10).isActive = true
        label.centerYAnchor.constraint(equalTo: backGroundView.centerYAnchor).isActive = true
        label.textColor = isDarkMode ? .black : .white
    }
    
    public func present(in viewController: UIViewController) {
        viewController.view.addSubview(self)
        self.activityIndicator.startAnimating()
    }
    
    public func remove() {
        self.removeFromSuperview()
    }
    
}
