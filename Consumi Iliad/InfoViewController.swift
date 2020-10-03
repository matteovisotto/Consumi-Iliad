//
//  InfoViewController.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 01/10/2020.
//

import UIKit

class InfoViewController: UIViewController {
    
    private let header = NavigationHeaderView()
    private let textView = UITextView()

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
        
        self.view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 5).isActive = true
        textView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        textView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5).isActive = true
        textView.isEditable = false
        textView.font = .systemFont(ofSize: 16)
        textView.text = load(file: "informazioni")
    }

    @objc private func dismissViewController() {
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    private func load(file name:String) -> String {

            if let path = Bundle.main.path(forResource: name, ofType: "txt") {

                if let contents = try? String(contentsOfFile: path) {

                    return contents

                } else {

                    print("Error! - This file doesn't contain any text.")
                }

            } else {

                print("Error! - This file doesn't exist.")
            }

            return ""
        }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.dismiss(animated: true, completion: nil)
    }
}
