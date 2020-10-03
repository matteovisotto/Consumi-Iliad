//
//  SettingsViewController.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 01/10/2020.
//

import UIKit
import MessageUI

class SettingsViewController: UIViewController {
    
    private let header = NavigationHeaderView()
    private var tableView = UITableView(frame: .zero, style: .insetGrouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        header.addTarget(target: self, selector: #selector(dismissViewController), for: .touchUpInside)
        header.title = "Impostazioni"
        registerCells()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
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
        
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 5).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        let footerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 20))
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        let appBundle = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
        footerLabel.text = "Versione " + appVersion + " ("+appBundle+")"
        footerLabel.textAlignment = .center
        footerLabel.font = .systemFont(ofSize: 12)
        tableView.tableFooterView = footerLabel
        
        tableView.tableHeaderView = SettingsTableViewHeader(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100))
    }
    
    private func registerCells() {
        tableView.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.cellIdentifier)
        tableView.register(TextTableViewCell.self, forCellReuseIdentifier: TextTableViewCell.cellIdentifier)
    }

    @objc private func dismissViewController() {
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func didCredentialStatusChange(_ sender: UISwitch){
        if(sender.isOn){
            UserDefaults.standard.set(true, forKey: "keepCredential")
            UserDefaults.standard.set("yes", forKey: "keepCredentialStr")
            UserDefaults.standard.set(Model.shared.login.username, forKey: "username")
            UserDefaults.standard.set(Model.shared.login.password, forKey: "password")
        } else {
            UserDefaults.standard.set(false, forKey: "keepCredential")
            UserDefaults.standard.set("no", forKey: "keepCredentialStr")
            UserDefaults.standard.removeObject(forKey: "username")
            UserDefaults.standard.removeObject(forKey: "password")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 1){
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section==2){
            let cell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.cellIdentifier) as! TextTableViewCell
            cell.setCell(cellDescription: "Logout", accessoryType: .none)
            cell.label.textColor = UIColor(named: "primary")
            return cell
        } else if(indexPath.section == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.cellIdentifier) as! SwitchTableViewCell
            cell.setCell(cellDescription: "Mantieni credenziali", target: self, selector: #selector(didCredentialStatusChange(_:)), forEvent: .valueChanged, withDefaultState: UserDefaults.standard.bool(forKey: "keepCredential"))
            return cell
            
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.cellIdentifier) as! TextTableViewCell
        if(indexPath.row == 0){
            cell.setCell(cellDescription: "Contatta lo sviluppatore", accessoryType: .disclosureIndicator)
        } else {
            cell.setCell(cellDescription: "Informazioni", accessoryType: .disclosureIndicator)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if(section == 0) {
            return "Disattivando questa opzione sarà necessario effettuare il login ad ogni avvio dell'applicazione"
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0){
            return "GENERALI"
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if(indexPath.section == 2 && indexPath.row == 0){
            UserDefaults.standard.removeObject(forKey: "username")
            UserDefaults.standard.removeObject(forKey: "password")
            Model.shared.login = Login(username: "", password: "")
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate
            else {
              return
            }
            let rootViewController = LoginViewController()
            sceneDelegate.window?.rootViewController = rootViewController
        } else if(indexPath.section == 1){
            if(indexPath.row == 0){
                let mailComposeViewController = configureMailController()
                if MFMailComposeViewController.canSendMail() {
                    self.present(mailComposeViewController, animated: true, completion: nil)
                } else {
                    let errorAlert = ErrorAlertController()
                    errorAlert.providesPresentationContextTransitionStyle = true
                    errorAlert.definesPresentationContext = true
                    errorAlert.modalPresentationStyle = .overFullScreen
                    errorAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                    errorAlert.setAlert(title: "Attenzione", message: "Non è stato possibile configurare il controllo. Verifica di aver configurato correttamene l'applicazione Mail")
                    self.present(errorAlert, animated: true, completion: nil)
                }
            } else if (indexPath.row == 1) {
                let infoVC = InfoViewController()
                self.navigationController?.pushViewController(infoVC, animated: true)
            }
        }
    }
}

extension SettingsViewController: MFMailComposeViewControllerDelegate {
    //Function to send an email
    func configureMailController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(["matteo.visotto@mail.polimi.it"])
        mailComposerVC.setSubject("[Consumi Iliad]")
        mailComposerVC.setMessageBody("", isHTML: true)
        
        return mailComposerVC
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
