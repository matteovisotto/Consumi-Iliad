//
//  DataManager.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 02/10/2020.
//

import Foundation

protocol DataManagerDelegate {
    func didFinish(withResult result: Bool, resultMessage: String)
}

class DataManager {
   
    enum DataType: String{
        case soglie = "https://iliad.it/account/"
        case storico = ""
    }
    
    open var delegate: DataManagerDelegate? = nil
    private let dataDownloader: DataDownloader!
    private let dataType: DataManager.DataType!
    
    init(dataType: DataManager.DataType) {
        self.dataType = dataType
        self.dataDownloader = DataDownloader(url: dataType.rawValue, method: .get, parameters: nil)
        dataDownloader.delegate = self
    }
    
    public func update() {
        dataDownloader.start()
    }
    
}

extension DataManager: DataDownloaderDelegate {
    func didDownloadedData(result: Bool, fromUrl: String, withData data: String) {
        if(!result){
            DispatchQueue.main.async {
                self.delegate?.didFinish(withResult: false, resultMessage: "Si è verificato un errore nella comunicazione con il server, riprova più tardi")
            }
            return
        }
        
        do {
            let error = try Parser.isLoginError(data: data)
            if(error.isError){
                self.delegate?.didFinish(withResult: false, resultMessage: error.errorMessage)
            } else {
                switch self.dataType {
                
                case .soglie:
                    //Update model
                    Model.shared.soglie = Soglie(minuti: Minuti(totali: "Illimitati", residui: ""), sms: Sms(totali: "Illimitati", residui: ""), internet: Internet(isUnlimited: false, totali: "50", residui: "10"), credito: Credito(residuo: "10,54", consumi: ""))
                    DispatchQueue.main.async {
                        self.delegate?.didFinish(withResult: true, resultMessage: "Soglie aggiornate correttamente")
                    }
                    break
                    
                case .storico:
                    //Update model
                    
                    DispatchQueue.main.async {
                        self.delegate?.didFinish(withResult: true, resultMessage: "Storico aggiornato correttamente")
                    }
                    break
                case .none:
                    DispatchQueue.main.async {
                        self.delegate?.didFinish(withResult: true, resultMessage: "Chiamata effettuata correttamente, nessuna modifica apportata")
                    }
                }
            }
        } catch {
            DispatchQueue.main.async {
                self.delegate?.didFinish(withResult: false, resultMessage: "Si è verifiato un errore durante l'analisi della pagina. Verificare da Safari se l'area clienti è correttamente disponibile.")
            }
        }
    }
    
    
}
