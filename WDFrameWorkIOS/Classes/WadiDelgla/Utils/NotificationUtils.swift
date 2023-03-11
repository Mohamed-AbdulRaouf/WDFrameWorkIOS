//
//  NotificationUtils.swift
//  STDobites
//
//  Created by SimpleTouch on 10/9/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
func doPostNotification(_ name: String){
    NotificationCenter.default.post(name: Notification.Name(name), object: nil)
}
extension UIViewController{
    func addobserverToNotification(_ selector : Selector,name: String){
        NotificationCenter.default.addObserver(self, selector: selector, name: Notification.Name(name), object: nil)
    }
    func removeNotificationObserver(_ name: String) {
           NotificationCenter.default.removeObserver(self, name: Notification.Name(name), object: nil)

       }
}
