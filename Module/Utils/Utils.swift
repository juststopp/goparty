//
//  Utils.swift
//  GoParty
//
//  Created by Malo Beaugendre on 05/08/2023.
//

import SwiftUI
import Foundation

class Utils {
    
    static func formatDateEnd(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY 'à' HH:mm"
        return dateFormatter.string(from: date)
    }
    
    static func formatDateHour(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
    static func sendNotification(title: String, message: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = message
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
}
