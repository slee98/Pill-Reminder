//
//  NotificationManager.swift
//  Pill Reminder
//
//  Created by Soyeon Lee on 11/11/23.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    static let shared = NotificationManager() //Singleton
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print("Notification Authorization ERROR: \(error)")
            } else {
                print("Successfully Authorized Notification")
            }
        }
    }
    
    func registerNotification(withTitle title: String, 
                              for dateComponents: DateComponents,
                              identifier: String?,
                              repeat: Bool) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.sound = .default
        content.badge = 1
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: identifier ?? UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func removeNotification(withIDs identifiers: [String]) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
    }
}
