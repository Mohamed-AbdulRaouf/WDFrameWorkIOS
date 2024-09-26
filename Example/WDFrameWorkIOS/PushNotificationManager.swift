//
//  PushNotificationManager.swift
//  WDFrameWorkIOS_Example
//
//  Created by Raouf on 10/03/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Firebase
import FirebaseMessaging
import UIKit
import UserNotifications
class PushNotificationManager: NSObject, MessagingDelegate, UNUserNotificationCenterDelegate {
    let userID: String
    init(userID: String) {
        self.userID = userID
        super.init()
        //test
    }
    
    func registerForPushNotifications(_ application:UIApplication) {
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { (didAllow, error) in
                if !didAllow {
                    print("User has declined notifications")
                }
            }
            UNUserNotificationCenter.current().getNotificationSettings { (settings) in
                if settings.authorizationStatus != .authorized {
                    // Notifications not allowed
                    print("User has declined notifications")
                }
            }
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        //  updateFirestorePushTokenIfNeeded()
        print("pushtoken \(fcmToken ?? "")")
        //pushToken = fcmToken
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(response)
    }
}
