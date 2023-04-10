//
//  Config.swift
//  WDFrameWorkIOS_Example
//
//  Created by Raouf on 10/03/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import WDFrameWorkIOS

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
    }
    static var googlePlacesAPIKey: String {
        return UIApplication.googlePlacesAPIKey
    }
    static var BRAND_ID: Int {
        return UIApplication.brandId
    }
    
    static var PayMobIntegrationID: Int {
        return 3694576
    }
    
    static var PayMobApiKey: String {
        return "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SndjbTltYVd4bFgzQnJJam8zTXpBd01EY3NJbTVoYldVaU9pSnBibWwwYVdGc0lpd2lZMnhoYzNNaU9pSk5aWEpqYUdGdWRDSjkuV3FBdnBOcHlCYzFGUDdiaU0tU0RCZGhVbWtDTjczUUJMMTZLRXAxRDYyZnJqUG9fdjZ1QXJReTAyb1FYZGhSekxhbWs5a0U4TklIbEdGa01NWEtIWmc="
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
