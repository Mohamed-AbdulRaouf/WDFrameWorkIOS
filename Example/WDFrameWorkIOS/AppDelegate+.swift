//
//  AppDelegate+.swift
//  WDFrameWorkIOS_Example
//
//  Created by Raouf on 10/03/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//


import UIKit
import WDFrameWorkIOS

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    var statusBarView : UIView? {
        if let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView {
            return statusBar
        }
        return nil
    }
    
    static var brandId: Int {
        return Int(Bundle.main.object(forInfoDictionaryKey: "BrandID") as! String) ?? 0
    }
    static var KASHIER_SDK_MODE: String {
        return Bundle.main.object(forInfoDictionaryKey: "KashierSDKMode") as! String
    }
    static var CustomerSourceId: Int {
        return Int(Bundle.main.object(forInfoDictionaryKey: "CustomerSourceId") as! String) ?? 0
    }
    static var googlePlacesAPIKey: String {
        return Bundle.main.object(forInfoDictionaryKey: "GOOGLE_PLACES_API_KEY") as! String
    }
}
