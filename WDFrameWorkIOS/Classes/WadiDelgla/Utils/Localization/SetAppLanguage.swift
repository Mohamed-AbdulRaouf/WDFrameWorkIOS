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
            UICollectionView.appearance().semanticContentAttribute = .forceRightToLeft
            UICollectionViewCell.appearance().semanticContentAttribute = .forceRightToLeft
            UITableViewCell.appearance().semanticContentAttribute = .forceRightToLeft
            UINavigationBar.appearance().semanticContentAttribute = .forceRightToLeft
            UITableView.appearance().semanticContentAttribute = .forceRightToLeft
            UIButton.appearance().semanticContentAttribute = .forceRightToLeft
            UIStackView.appearance().semanticContentAttribute = .forceRightToLeft
            UITextView.appearance().semanticContentAttribute = .forceRightToLeft
            UITextField.appearance().semanticContentAttribute = .forceRightToLeft
            UISegmentedControl.appearance().semanticContentAttribute = .forceRightToLeft
        }else {
            L102Language.setAppleLAnguageTo(lang: "en")
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UILabel.appearance().semanticContentAttribute = .forceLeftToRight
            UICollectionView.appearance().semanticContentAttribute = .forceLeftToRight
            UICollectionViewCell.appearance().semanticContentAttribute = .forceLeftToRight
            UITableViewCell.appearance().semanticContentAttribute = .forceLeftToRight
            UINavigationBar.appearance().semanticContentAttribute = .forceLeftToRight
            UITableView.appearance().semanticContentAttribute = .forceLeftToRight
            UIButton.appearance().semanticContentAttribute = .forceLeftToRight
            UIStackView.appearance().semanticContentAttribute = .forceLeftToRight
            UITextView.appearance().semanticContentAttribute = .forceLeftToRight
            UITextField.appearance().semanticContentAttribute = .forceLeftToRight
            UISegmentedControl.appearance().semanticContentAttribute = .forceLeftToRight
        }
        UINavigationBar.appearance().tintColor = .black
    }
}
