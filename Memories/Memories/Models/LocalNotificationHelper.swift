//
//  LocalNotificationHelper.swift
//  Memories
//
//  Created by David Oliver Doswell on 8/1/18.
//  Copyright © 2018 David Oliver Doswell. All rights reserved.
//

import Foundation
import UserNotifications

class LocalNotificationHelper {
    
    // helper methods for requesting and getting authorization
    func getAuthorizationStatus(completion: @escaping (UNAuthorizationStatus) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            DispatchQueue.main.async {
                completion(settings.authorizationStatus)
            }
        }
    }
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            
            if let error = error {
                NSLog("Error requesting authorization status for local notifications: \(error)") }
            
            DispatchQueue.main.async {
                completion(success)
            }
        }
    }
    
    private let identifier = "notification"
    
    // set up a local notification to fire every day at 8 PM
    func scheduleDailyReminderNotification() {
        
        var date = DateComponents()
        date.hour = 20

        let content = UNMutableNotificationContent()
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if let error = error {
                NSLog("Error scheduling notification \(error)")
                return
            }
        }
    }
    
}
