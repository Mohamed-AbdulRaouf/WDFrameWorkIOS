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
    var mainStoryboard: UIStoryboard = UIStoryboard()
    var viewController: UIViewController = UIViewController()
    var password: String = "123456"
    
    init() {}
    
    init(name: String, mobile: String, email: String, membershipNumber: String, mainStoryboard: UIStoryboard,
         viewController: UIViewController) {
        self.name = name
        self.mobile = mobile
        self.email = email
        self.membershipNumber = membershipNumber
        self.mainStoryboard = mainStoryboard
        self.viewController = viewController
    }
    
}
