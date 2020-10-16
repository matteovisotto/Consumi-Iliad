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
        case soglie = "https://iliad.it/account/consumi-e-credito"
        case storico = "https://iliad.it/account/consumi-e-credito?historyId=0"
        case offerta = "https://www.iliad.it/account/la-mia-offerta"
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
                    let soglieParser = try SoglieParser(dataString: data)
                    Model.shared.soglie = (try soglieParser.parse() as? Soglie)
                    DispatchQueue.main.async {
                        NotificationManager.updateNotificationData(forNewDateAsString: Model.shared.soglie?.rinnovo ?? "01/01/2020") { (result) in
                            if(!result){
                                self.delegate?.didFinish(withResult: false, resultMessage: "Soglie aggiornate ma si è verificato un errore nell'aggiornamento del sistema di notifiche")
                            }
                        }
                    }
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
                case .offerta:
                    let offertaParser = try OffertaParser(dataString: data)
                    Model.shared.offerta = (try offertaParser.parse() as? Offerta)
                    DispatchQueue.main.async {
                        self.delegate?.didFinish(withResult: true, resultMessage: "Offerta aggiornata correttamente")
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
