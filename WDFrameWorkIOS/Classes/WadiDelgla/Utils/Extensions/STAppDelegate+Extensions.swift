//
//  STAppDelegate+Extensions.swift
//  STDobites
//
//  Created by SimpleTouch on 10/17/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
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
    
    func setupUI(){
        K.shared.APP_LANGUAGE  = UserDefaults.currentAppLanguage
        Bundle.setLanguage(K.shared.APP_LANGUAGE)

        UINavigationBar.setColors(background: COLOR_ACCENT, text: .darkGray)
        UINavigationBar.setTitleFont(UIFont(resource: APP_FONT_BOLD, size: 20)!, color: .black)
        if #available(iOS 13.0, *) {
                let statusBar = UIView(frame: UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
                 statusBar.backgroundColor = COLOR_STATUS_BAR
                 UIApplication.shared.keyWindow?.addSubview(statusBar)
            } else {
                 UIApplication.shared.statusBarView?.backgroundColor = COLOR_STATUS_BAR
            }
//        IQKeyboardManager.shared.enable = true
//        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysShow
//        IQKeyboardManager.shared.toolbarPreviousNextAllowedClasses.append(STUIView.self)
    }
}
