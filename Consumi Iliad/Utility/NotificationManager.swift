//
//  NotificationManager.swift
//  Consumi Iliad
//
//  Created by Matteo Visotto on 16/10/2020.
//

import UIKit

class NotificationManager {
    
    static func updateNotificationData(forNewDateAsString date: String, completion: @escaping (_ result: Bool) -> ()){
        NotificationManager.disableNotifications()
        var dateComponents = DateComponents()
        dateComponents.hour = 9
        dateComponents.day = Int(NotificationManager.getNotificationDay(str: date))
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        // 2
        let content = UNMutableNotificationContent()
        content.title = "Rinnovo"
        content.body = "Domani la tua offerta si rinnova, assicurati di aver credito sufficiente"

        let randomIdentifier = UUID().uuidString
        let request = UNNotificationRequest(identifier: randomIdentifier, content: content, trigger: trigger)

        // 3
        UNUserNotificationCenter.current().add(request) { error in
          if error != nil {
            DispatchQueue.main.async {
                completion(false)
            }
          } else {
            DispatchQueue.main.async {
                completion(true)
            }
            
          }
        }
    }
    
    static func enableNotification(forDateAsString date: String, completion: @escaping (_ result: Bool) -> ()) {
        var dateComponents = DateComponents()
        dateComponents.hour = 9
        dateComponents.day = Int(NotificationManager.getNotificationDay(str: date))
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        // 2
        let content = UNMutableNotificationContent()
        content.title = "Rinnovo"
        content.body = "Domani la tua offerta si rinnova, assicurati di aver credito sufficiente"

        let randomIdentifier = UUID().uuidString
        let request = UNNotificationRequest(identifier: randomIdentifier, content: content, trigger: trigger)

        // 3
        UNUserNotificationCenter.current().add(request) { error in
          if error != nil {
            DispatchQueue.main.async {
                completion(false)
            }
          } else {
            DispatchQueue.main.async {
                completion(true)
            }
            
          }
        }
    }
    
    static func disableNotifications() {
        let center = UNUserNotificationCenter.current()
            center.removeAllDeliveredNotifications()    // to remove all delivered notifications
            center.removeAllPendingNotificationRequests()   // to remove all pending notifications
            UIApplication.shared.applicationIconBadgeNumber = 0 // to clear the icon notification badge
    }
    
    private static func getNotificationDay(str: String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        formatter.locale = Calendar.current.locale
        formatter.timeZone = Calendar.current.timeZone
        let date = formatter.date(from: str)!
        let dayBefore = Calendar.current.date(byAdding: .day, value: -1, to: date)!
        let newDateStr = formatter.string(from: dayBefore)
        let day = String(newDateStr[newDateStr.startIndex..<newDateStr.index(str.startIndex, offsetBy: 2)])
        return day
    }
}
