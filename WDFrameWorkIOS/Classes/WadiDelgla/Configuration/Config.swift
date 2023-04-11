//
//  Config.swift
//  STDobites
//
//  Created by SimpleTouch on 12/31/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//


import UIKit
//import BLL
////import DAL
//import KashierPaymentSDK

//MARK: - GLOBAL VARIABLES
class K{
    static let shared = K()
    private init() {}
    var SELECTED_BRAND : IBrandDTODAL?
    var APP_LANGUAGE : String = "en"
    var APP_COUNTRY_Id : String = ""
    var BRAND_COUNTRY_LIST : [CountryDTODAL]?
    var ALL_AVAILABLE_COUNTRY_LIST : [CountryDTODAL]?
}

//MARK: - CONFIGURATION
class Config {
    static var TestUserPhoneNumber: String {
        return "01004276126"
    }
    static var TestVerifyCode: String{
        return "123456"
    }
    static var kashierSDKMode: String {
        return "Production"
//        return UIApplication.KASHIER_SDK_MODE == "Production" ? .PRODUCTION : .DEVELOPMENT
    }
    static var googlePlacesAPIKey: String {
        return UIApplication.googlePlacesAPIKey
    }
    static var BRAND_ID: Int {
        return UIApplication.brandId
    }
//    static var BRAND_NAME_EN: String {
//        return UIApplication.BRAND_NAME_EN
//    }
//    static var BRAND_NAME_AR: String {
//        return UIApplication.BRAND_NAME_AR
//    }
}
//MARK: - BLL CONFIGURATION
extension Config: BLLConfigBLL {
    static var language: String {
        return LocalizationSystem.sharedInstance.getLanguage()
    }
    static var customerSourceId: Int {
        return UIApplication.CustomerSourceId
    }
    static var fcmToken: String{
        return UserDefaults.fcmToken
    }
}


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
