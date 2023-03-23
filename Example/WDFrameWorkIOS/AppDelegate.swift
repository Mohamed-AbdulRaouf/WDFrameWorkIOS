//
//  AppDelegate.swift
//  WDFrameWorkIOS
//
//  Created by mohamed.a.raouf@icloud.com on 03/09/2023.
//  Copyright (c) 2023 mohamed.a.raouf@icloud.com. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard
import RswiftResources
import IQKeyboardManagerSwift
import Firebase
import SwifterSwift
import FirebaseCore
import FirebaseMessaging
import GoogleMaps
import GooglePlaces
import WDFrameWorkIOS

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    static var shared = AppDelegate()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.window = window
        
        // google maps api
        GMSServices.provideAPIKey(Config.googlePlacesAPIKey)
        // google places api
        GMSPlacesClient.provideAPIKey(Config.googlePlacesAPIKey)
        // Configure Firebase
        // ------------------
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        Messaging.messaging().delegate = self
        let pushManager = PushNotificationManager(userID: "currently_logged_in_user_id")
        pushManager.registerForPushNotifications(application)
        
        UNUserNotificationCenter.current().delegate = self
        if #available(iOS 13.0, *) {
            window.overrideUserInterfaceStyle = .light
        }
        if #available(iOS 10.0, *){
            //For iOS 10 display notifiication ( sent via APNS )
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert,.badge,.sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { (_, _) in }
            
        }else{
            let settings : UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert,.badge,.sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.applicationIconBadgeNumber = 0
        application.registerForRemoteNotifications()
        let bundlePath = Bundle(for: TestViewController.self).path(forResource: "resources", ofType: "bundle")
        let bundle = Bundle(path: bundlePath!)
        let WDStoryboard: UIStoryboard = UIStoryboard(name: "TestStoryboard", bundle: bundle)
        let vc = WDStoryboard.instantiateViewController(withIdentifier: "TestViewController") as! TestViewController
        self.window?.rootViewController = UINavigationController(rootViewController: vc.create(name: "sobhy", mobile: "01113713682", email: "msobhy@gmail.com", membershipNumber: "123456", mainStoryboard: UIStoryboard(name: "Main", bundle: Bundle.main), viewController: UIApplication.topViewController() ?? UIViewController()))
        return true
    }
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        //        K.shared.APP_LANGUAGE  = UserDefaults.currentAppLanguage
        //        Bundle.setLanguage(K.shared.APP_LANGUAGE)
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate{
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        completionHandler()
    }
    
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
        
    }
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        
        print(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    }
    
}
extension AppDelegate: MessagingDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        Messaging.messaging().apnsToken = deviceToken
        print("Device Token: \(token)")
        
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        UserDefaults.fcmToken = fcmToken ?? ""
        print("pushToken =  \(fcmToken ?? "")")
    }
}
