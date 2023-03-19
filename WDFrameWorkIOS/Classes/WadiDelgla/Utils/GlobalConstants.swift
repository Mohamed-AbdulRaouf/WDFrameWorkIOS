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
    
    init() {}
    
    init(name: String, mobile: String, email: String, membershipNumber: String) {
        self.name = name
        self.mobile = mobile
        self.email = email
        self.membershipNumber = membershipNumber
    }
    
    
    public static var shared = GlobalConstants()
    
}
