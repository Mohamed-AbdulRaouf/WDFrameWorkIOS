//
//  GlobalConstants.swift
//  WDFrameWorkIOS
//
//  Created by Raouf on 17/03/2023.
//

import Foundation

class GlobalConstants {
    
    var name: String = ""
    var mobile: String = ""
    var email: String = ""
    var membershipNumber: String = ""
    var mainHomeScreen: UIViewController = UIViewController()
    
    init() {}
    
    init(name: String, mobile: String, email: String, membershipNumber: String, mainHomeScreen: UIViewController) {
        self.name = name
        self.mobile = mobile
        self.email = email
        self.membershipNumber = membershipNumber
        self.mainHomeScreen = mainHomeScreen
    }
    
    
    static var shared = GlobalConstants()
    
}
