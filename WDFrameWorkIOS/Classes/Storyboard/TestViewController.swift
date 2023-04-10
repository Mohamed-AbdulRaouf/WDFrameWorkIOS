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
        self.navigationController?.isNavigationBarHidden = true
        debugPrint("TestViewController Loaded")
        setUIAppearance()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let vc = StoryboardScene.Location.locationViewController.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setUIAppearance() {
        if LocalizationSystem().isCurrentLanguageArabic() {
            SetAppLanguage.shared.doFurtherProcessingWithResult(languageCode: "ar")
        } else {
            SetAppLanguage.shared.doFurtherProcessingWithResult(languageCode: "en")
        }
    }
    
}

extension TestViewController {
    
    public func create(name: String, mobile: String, email: String, membershipNumber: String, mainStoryboard: UIStoryboard, viewController: UIViewController, language: String) -> TestViewController {
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
        Bundle.setLanguage(language)
        return vc
    }
    
}
