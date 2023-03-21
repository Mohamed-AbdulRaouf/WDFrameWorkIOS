//
//  GlobalConstants.swift
//  WDFrameWorkIOS
//
//  Created by Raouf on 17/03/2023.
//

import Foundation

class GlobalConstants {
    
    static var shared = GlobalConstants()
    
    var name: String = ""
    var mobile: String = ""
    var email: String = ""
    var membershipNumber: String = ""
    var mainHomeScreen: String = ""
    
    init() {}
    
    init(name: String, mobile: String, email: String, membershipNumber: String, mainHomeScreen: String) {
        self.name = name
        self.mobile = mobile
        self.email = email
        self.membershipNumber = membershipNumber
        self.mainHomeScreen = mainHomeScreen
    }
    
}
