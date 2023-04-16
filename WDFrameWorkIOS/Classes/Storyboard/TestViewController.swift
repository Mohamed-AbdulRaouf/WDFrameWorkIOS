//
//  TestViewController.swift
//  WDFrameWorkIOS
//
//  Created by Raouf on 09/03/2023.
//

import UIKit

public class TestViewController: UIViewController {

    var firstName = ""
    var lastName = ""
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
        let vc = StoryboardScene.User.registerViewController.instantiate()
        self.navigationController?.pushViewController(vc)
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
    
    public func create(firstName: String, lastName: String = "NA", mobile: String, email: String, membershipNumber: String, language: String) -> TestViewController {
        let vc = TestViewController()
        vc.firstName = firstName
        vc.lastName = lastName
        vc.mobile = mobile
        vc.email = email
        vc.membershipNumber = membershipNumber
        GlobalConstants.shared.firstName = firstName
        GlobalConstants.shared.lastName = lastName == "" ? "NA" : lastName
        GlobalConstants.shared.mobile = mobile
        GlobalConstants.shared.email = email
        GlobalConstants.shared.membershipNumber = membershipNumber
        UserDefaults.loginData?.mobile.value = mobile
        UserDefaults.loginData?.password.value = GlobalConstants.shared.password
        UserDefaults.loginData?.brandId.value = 0
        // reset choose area and club, if language is changed
        if L102Language.currentAppleLanguageFull() != language {
            UserDefaults.currentArea = nil
            UserDefaults.currentCity = nil
        }
        Bundle.setLanguage(language)
        return vc
    }
    
}
