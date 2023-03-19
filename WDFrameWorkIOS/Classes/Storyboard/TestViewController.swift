//
//  TestViewController.swift
//  WDFrameWorkIOS
//
//  Created by Raouf on 09/03/2023.
//

import UIKit

public class TestViewController: UIViewController {

    var name = ""
    var mobile = ""
    var email = ""
    var membershipNumber = ""
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint("TestViewController Loaded")
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        let vc = StoryboardScene.Location.locationViewController.instantiate()
        let vc = StoryboardScene.User.loginViewController.instantiate()
        let window = UIApplication.shared.keyWindow
        window?.rootViewController = UINavigationController(rootViewController: vc)
    }

}

extension TestViewController {
    
    public func create(name: String, mobile: String, email: String ,membershipNumber: String) -> TestViewController {
        let vc = TestViewController()
        vc.name = name
        vc.mobile = mobile
        vc.email = email
        vc.membershipNumber = membershipNumber
        GlobalConstants(name: name, mobile: mobile, email: email, membershipNumber: membershipNumber)
        UserDefaults.loginData?.mobile.value = mobile
        UserDefaults.loginData?.password.value = membershipNumber
        UserDefaults.loginData?.brandId.value = 4
        UserDefaults.loginData?.countryId.value = "1"
        UserDefaults.loginData?.dialCode.value = "+2"
        return vc
    }
    
}
