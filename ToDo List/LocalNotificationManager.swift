//
//  LocalNotificationManager.swift
//  ToDo List
//
//  Created by Derek Marble on 2/27/22.
//

import UIKit
import UserNotifications

struct LocalNotificationManager {
    //This is for authorizing LOCAL Notifications
    static func authorizeUserNotification(viewController: UIViewController) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { granted, error in
            guard error == nil else {
                print("Error: \(error!.localizedDescription)")
                return
            }
            if granted {
                print("Notifications authorization granted!")
            } else {
                print("The user has denied notifications!")
                DispatchQueue.main.async {
                    viewController.oneButtonAlert(title: "User Has Not Allowed Notifications", message: "To recieve alerts for reminders, open the Settings app, select To Do List > Notifications > Allow Notifications")
                }
            }
        }
    }
    
    static func isAuthorized(completed: @escaping (Bool) -> () ) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { granted, error in
            guard error == nil else {
                print("Error: \(error!.localizedDescription)")
                completed(false)
                return
            }
            if granted {
                print("Notifications authorization granted!")
                completed(true)
            } else {
                print("The user has denied notifications!")
                completed(false)

            }
        }
    }
    static func setCalendarNotification(title: String, subtitle: String, body: String, badgeNumber: NSNumber?, sound: UNNotificationSound?, date: Date) -> String {
        //Create Content
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.sound = sound
        content.badge = badgeNumber
        
        // create trigger
        var dateComponents = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: date)
        dateComponents.second = 00
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        // create request
        let notificationID = UUID().uuidString
        let request = UNNotificationRequest(identifier: notificationID, content: content, trigger: trigger)
        
        // register request with notification center
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("ERROR: \(error.localizedDescription) Adding notification request went wrong!")
            } else {
                print("Notification scheduled \(notificationID), title: \(content.title)")
            }
        }
        return notificationID
    }
}
