//
//  NotofocationsManager.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 26.01.2023.
//

import Foundation
import UserNotifications

final class NotificationsManager {
    private let center = UNUserNotificationCenter.current()
    
    func checkNotificationsStatus() -> Bool {
        var access = true
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .denied {
                print("Notifications denied")
                access = false
            }
        }
        return access
    }
    
    func sendMovieExistNotification() {
        var access = true
        center.getNotificationSettings(completionHandler: { settings in
            if settings.authorizationStatus == .denied {
                print("Notifications denied")
                access = false
            }
        })
        if !access {
            return
        }
        let content = UNMutableNotificationContent()
        content.title = "Download is canceled"
        content.subtitle = "Movie already exists"
        content.sound = UNNotificationSound.default

        let request = UNNotificationRequest(identifier: "success.notif", content: content, trigger: nil)
        center.add(request)
    }
    
    func sendSuccessNotification(filmTitle: String) {
        if !checkNotificationsStatus() {
            return
        }
        let content = UNMutableNotificationContent()
        content.title = filmTitle
        content.subtitle = "The movie has been downloaded successfully!"
        content.sound = UNNotificationSound.default

        let request = UNNotificationRequest(identifier: "success.notif", content: content, trigger: nil)
        center.add(request)
    }
    
    func sendErrorNotification() {
        if !checkNotificationsStatus() {
            return
        }
        let content = UNMutableNotificationContent()
        content.title = "Sorry"
        content.subtitle = "Something went wrong. Please try again later"
        content.sound = UNNotificationSound.default

        let request = UNNotificationRequest(identifier: "success.notif", content: content, trigger: nil)
        center.add(request)
    }
}
