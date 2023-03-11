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
        return UserDefaults.currentAppLanguage
    }
    static var customerSourceId: Int {
        return UIApplication.CustomerSourceId
    }
    static var fcmToken: String{
        return UserDefaults.fcmToken
    }
}
