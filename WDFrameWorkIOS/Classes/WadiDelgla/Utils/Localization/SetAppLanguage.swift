//
//  SetAppLanguage.swift
//  shop_customer
//
//  Created by mohamed on 9/25/22.
//  Copyright © 2022 Mahallat Online. All rights reserved.
//

import UIKit
import Localize_Swift
import MOLH

class SetAppLanguage {
    
    static var shared = SetAppLanguage()
    
    func setLanguage(languageCode: String) {
        if languageCode == "ar" {
            Localize.setCurrentLanguage("ar")
            UserDefaults.standard.set(["ar"], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
            LocalizationSystem.sharedInstance.setLanguage(languageCode: "ar")
            object_setClass(Bundle.main, Bundle.self)
            
            let bundle = Bundle(path: Bundle.main.path(forResource: "ar", ofType: "lproj")!)
            objc_setAssociatedObject(Bundle.main, &_BUNDLE_KEY, bundle, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }else{
            Localize.setCurrentLanguage("en")
            UserDefaults.standard.set(["en"], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
            LocalizationSystem.sharedInstance.setLanguage(languageCode: "en")
            object_setClass(Bundle.main, Bundle.self)
            
            let bundle = Bundle(path: Bundle.main.path(forResource: "en", ofType: "lproj")!)
            objc_setAssociatedObject(Bundle.main, &_BUNDLE_KEY, bundle, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        doFurtherProcessingWithResult(languageCode: languageCode)
    }
    
    func doFurtherProcessingWithResult(languageCode: String) {
        let defaults = UserDefaults.standard
        defaults.set(languageCode, forKey: "language")
        defaults.synchronize()
        if languageCode == "ar" {
            L102Language.setAppleLAnguageTo(lang: "ar")
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            UILabel.appearance().semanticContentAttribute = .forceRightToLeft
        }else {
            L102Language.setAppleLAnguageTo(lang: "en")
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UILabel.appearance().semanticContentAttribute = .forceLeftToRight
        }
        let mainwindow = (UIApplication.shared.delegate?.window!)!
        mainwindow.backgroundColor = UIColor(hue: 0.6477, saturation: 0.6314, brightness: 0.6077, alpha: 0.8)
//        AppDelegate.shared.setAppearance()
    }
}
