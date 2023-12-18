//
//  UserDefaults.swift
//  AsthmaApp
//
//  Created by Raouf on 18/03/2023.
//

import Foundation

class UserDefaultsApp {
    
    static var shared = UserDefaultsApp()
    
    var auth_token: String {
        set {
            UserDefaults.standard.set(newValue, forKey: "auth_token")
        }
        get {
            return UserDefaults.standard.string(forKey: "auth_token") ?? ""
        }
    }
    
    var orderPayID: String {
        set {
            UserDefaults.standard.set(newValue, forKey: "orderPayID")
        }
        get {
            return UserDefaults.standard.string(forKey: "orderPayID") ?? ""
        }
    }
    
    var orderPaymentKey: String {
        set {
            UserDefaults.standard.set(newValue, forKey: "orderPaymentKey")
        }
        get {
            return UserDefaults.standard.string(forKey: "orderPaymentKey") ?? ""
        }
    }
    
    var orderID: Int {
        set {
            UserDefaults.standard.set(newValue, forKey: "wd_order_id")
        }
        get {
            return UserDefaults.standard.integer(forKey: "wd_order_id")
        }
    }
    
}
