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
    var mainStoryboard = UIStoryboard()
    var viewController = UIViewController()
    
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
    
    public func create(name: String, mobile: String, email: String ,membershipNumber: String, mainStoryboard: UIStoryboard, viewController: UIViewController) -> TestViewController {
        let vc = TestViewController()
        vc.name = name
        vc.mobile = mobile
        vc.email = email
        vc.membershipNumber = membershipNumber
        GlobalConstants.shared.name = name
        GlobalConstants.shared.mobile = mobile
        GlobalConstants.shared.email = email
        GlobalConstants.shared.membershipNumber = membershipNumber
        GlobalConstants.shared.mainStoryboard = mainStoryboard
        GlobalConstants.shared.viewController = viewController
        UserDefaults.loginData?.mobile.value = mobile
        UserDefaults.loginData?.password.value = membershipNumber
        UserDefaults.loginData?.brandId.value = 0
//        UserDefaults.loginData?.countryId.value = "1"
//        UserDefaults.loginData?.dialCode.value = "+2"
        return vc
    }
    
}
