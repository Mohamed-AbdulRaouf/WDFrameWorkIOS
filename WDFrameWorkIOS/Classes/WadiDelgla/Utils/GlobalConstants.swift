//
//  GlobalConstants.swift
//  WDFrameWorkIOS
//
//  Created by Raouf on 17/03/2023.
//

import Foundation

class GlobalConstants {
    
    static var shared = GlobalConstants()
    
    var firstName: String = ""
    var lastName: String = "NA"
    var mobile: String = ""
    var email: String = ""
    var membershipNumber: String = ""
    var password: String = "123456"
    
    init() {}
    
    init(firstName: String, lastName: String, mobile: String, email: String, membershipNumber: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.mobile = mobile
        self.email = email
        self.membershipNumber = membershipNumber
    }
    
}
