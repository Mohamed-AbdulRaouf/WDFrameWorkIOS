//
//  STUserdefaults+Extensions.swift
//  BLL
//
//  Created by SimpleTouch on 10/21/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
/*---UserDefaults---*/
public extension UserDefaults {
    //makes the string safer
    enum UserDefaultsKeysBLL: String {
        case user = "wd_user"
        case language = "STLanguage"
        case fcmToken = "wd_FCMToken"
        case currentCity = "currentcity"
        case currentArea = "currentarea"
        case streetName = "streetName"
        case userRecentCuisineFilterWordsKey = "UserRecentCuisineFilterWordsKey"
        case userRecentFaciltiesFilterWordsKey = "UserRecentFaciltiesFilterWordsKey"
        case order = "wd_Order"
        case fileGeneration = "fileGeneration"
        case apiErrors = "apiErrors"
        case appNeedsWalkthroughKey = "appNeedsWalkthroughKey"
        case brandPaymentData = "brandPaymentData"
        case currentAppCountry = "currentAppCountry"
        case loginData = "wd_loginData"
        case brandInfo = "brandInfo"
        case showNotRatedOrders = "showNotRatedOrders"
        case myFatoorahBrandPaymentDataDTO = "myFatoorahBrandPaymentDataDTO"
        case enableShowQRCodeVC = "enableShowQRCodeVC"
        case orderPhone = "orderPhone"
    }
    static var user : UserDTODAL? {
        get {
            if let data = UserDefaults.standard.value(forKey:UserDefaultsKeysBLL.user.rawValue) as? Data {
                let user = try? PropertyListDecoder().decode(UserDTODAL.self, from: data)
                return user
            }
            return nil
        }
        set{
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: UserDefaultsKeysBLL.user.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    static var loginData : LoginDTODAL? {
        get {
                  if let data = UserDefaults.standard.value(forKey:UserDefaultsKeysBLL.loginData.rawValue) as? Data {
                      let login = try? PropertyListDecoder().decode(LoginDTODAL.self, from: data)
                      return login
                  }
                  return nil
              }
              set{
                  UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: UserDefaultsKeysBLL.loginData.rawValue)
                  UserDefaults.standard.synchronize()
              }
    }
 
    static var currentAppLanguage : String {
        get {
            return UserDefaults.standard.value(forKey:UserDefaultsKeysBLL.language.rawValue) as? String ?? "en"
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeysBLL.language.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
      static var currentAppCountry : CountryDTODAL? {
          get {
              if let data = UserDefaults.standard.value(forKey:UserDefaultsKeysBLL.currentAppCountry.rawValue) as? Data {
                  let country = try? PropertyListDecoder().decode(CountryDTODAL.self, from: data)
                  return country
              }
              return nil
          }
          set{
              UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: UserDefaultsKeysBLL.currentAppCountry.rawValue)
              UserDefaults.standard.synchronize()
          }
      }
    static var fcmToken : String {
        get {
            return  UserDefaults.standard.value(forKey:UserDefaultsKeysBLL.fcmToken.rawValue) as? String ?? ""
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeysBLL.fcmToken.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    static var currentCity : SearchItemDTOModelDAL? {
        get {
            if let data = UserDefaults.standard.value(forKey:UserDefaultsKeysBLL.currentCity.rawValue) as? Data {
                let city = try? PropertyListDecoder().decode(SearchItemDTOModelDAL.self, from: data)
                return city
            }
            return nil
        }
        set{
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: UserDefaultsKeysBLL.currentCity.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    static var currentArea : SearchItemDTOModelDAL? {
        get {
            if let data = UserDefaults.standard.value(forKey:UserDefaultsKeysBLL.currentArea.rawValue) as? Data {
                let area = try? PropertyListDecoder().decode(SearchItemDTOModelDAL.self, from: data)
                return area
            }
            return nil
        }
        set{
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: UserDefaultsKeysBLL.currentArea.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    static var streetName : String {
        get {
            return  UserDefaults.standard.value(forKey:UserDefaultsKeysBLL.streetName.rawValue) as? String ?? ""
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeysBLL.streetName.rawValue)
            UserDefaults.standard.synchronize()
        }
    }

    static var recentCuisineFilterSearches : [String]? {
        get {
            if let recentSearchWords = UserDefaults.standard.value(forKey:UserDefaultsKeysBLL.userRecentCuisineFilterWordsKey.rawValue) as? [String] {
                return recentSearchWords
            }
            return nil
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeysBLL.userRecentCuisineFilterWordsKey.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    static var recentFaciltiesFilterSearches : [String]? {
        get {
            if let recentSearchWords = UserDefaults.standard.value(forKey:UserDefaultsKeysBLL.userRecentFaciltiesFilterWordsKey.rawValue) as? [String] {
                return recentSearchWords
            }
            return nil
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeysBLL.userRecentFaciltiesFilterWordsKey.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    static var order : STCheckoutOrderDTODAL? {
        get {
            if let data = UserDefaults.standard.value(forKey:UserDefaultsKeysBLL.order.rawValue) as? Data {
                let city = try? PropertyListDecoder().decode(STCheckoutOrderDTODAL.self, from: data)
                return city
            }
            return nil
        }
        set{
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: UserDefaultsKeysBLL.order.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    static var fileGeneration : Int64? {
        get {
            if let fileGeneration = UserDefaults.standard.value(forKey:UserDefaultsKeysBLL.fileGeneration.rawValue) as? Int64 {
                return fileGeneration
            }
            return nil
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeysBLL.fileGeneration.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
    static var isAppNeedsWalkthrough : Bool?{
        get {
            if let isneed = UserDefaults.standard.value(forKey:UserDefaultsKeysBLL.appNeedsWalkthroughKey.rawValue) as? Bool {
                return isneed
            }
            return nil
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeysBLL.appNeedsWalkthroughKey.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    static var apiErrors : [CustomErrorDTODAL]? {
        get {
            if let data = UserDefaults.standard.value(forKey:UserDefaultsKeysBLL.apiErrors.rawValue) as? Data {
                let errors = try? PropertyListDecoder().decode(Array<CustomErrorDTODAL>.self, from: data)
                return errors
            }
            return nil
        }
        set{
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: UserDefaultsKeysBLL.apiErrors.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
    static var brandPaymentData : BrandPaymentDataDTODAL? {
        get {
            if let data = UserDefaults.standard.value(forKey:UserDefaultsKeysBLL.brandPaymentData.rawValue) as? Data {
                let paymentData = try? PropertyListDecoder().decode(BrandPaymentDataDTODAL.self, from: data)
                return paymentData
            }
            return nil
        }
        set{
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: UserDefaultsKeysBLL.brandPaymentData.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    static var myFatoorahBrandPaymentData : MyFatoorahBrandPaymentDataDTODAL? {
        get {
            if let data = UserDefaults.standard.value(forKey:UserDefaultsKeysBLL.myFatoorahBrandPaymentDataDTO.rawValue) as? Data {
                let paymentData = try? PropertyListDecoder().decode(MyFatoorahBrandPaymentDataDTODAL.self, from: data)
                return paymentData
            }
            return nil
        }
        set{
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: UserDefaultsKeysBLL.myFatoorahBrandPaymentDataDTO.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    static var brandInfo : BrandDTODAL? {
           get {
               if let data = UserDefaults.standard.value(forKey:UserDefaultsKeysBLL.brandInfo.rawValue) as? Data {
                   let brandData = try? PropertyListDecoder().decode(BrandDTODAL.self, from: data)
                   return brandData
               }
               return nil
           }
           set{
               UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: UserDefaultsKeysBLL.brandInfo.rawValue)
               UserDefaults.standard.synchronize()
           }
       }
    static var showNotRatedOrders : Bool?{
          get {
              if let show = UserDefaults.standard.value(forKey:UserDefaultsKeysBLL.showNotRatedOrders.rawValue) as? Bool {
                  return show
              }
              return nil
          }
          set{
              UserDefaults.standard.set(newValue, forKey: UserDefaultsKeysBLL.showNotRatedOrders.rawValue)
              UserDefaults.standard.synchronize()
          }
      }
    static var enableShowQRCodeVC : Bool?{
        get {
            if let isneed = UserDefaults.standard.value(forKey:UserDefaultsKeysBLL.enableShowQRCodeVC.rawValue) as? Bool {
                return isneed
            }
            return nil
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeysBLL.enableShowQRCodeVC.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
    static var orderPhone : String {
        get {
            return UserDefaults.standard.value(forKey:UserDefaultsKeysBLL.orderPhone.rawValue) as? String ?? ""
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeysBLL.orderPhone.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
}

public func saveJSON(j: JSON?,forKey key :String) {
    let defaults = UserDefaults.standard
    defaults.setValue(j?.rawString(), forKey: key)
    UserDefaults.standard.synchronize()
    // here I save my JSON as a string
}
public func loadJSON(forKey key: String) -> JSON {
    let defaults = UserDefaults.standard
    return JSON.init(parseJSON: defaults.value(forKey: key) as! String)
    // JSON from string must be initialized using .parse()
}
