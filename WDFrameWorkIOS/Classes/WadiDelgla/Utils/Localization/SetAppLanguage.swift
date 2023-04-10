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
            UINavigationBar.appearance().semanticContentAttribute = .forceLeftToRight
            UITableView.appearance().semanticContentAttribute = .forceLeftToRight
            UIButton.appearance().semanticContentAttribute = .forceLeftToRight
            UIStackView.appearance().semanticContentAttribute = .forceLeftToRight
            UITextView.appearance().semanticContentAttribute = .forceLeftToRight
            UITextField.appearance().semanticContentAttribute = .forceLeftToRight
            UISegmentedControl.appearance().semanticContentAttribute = .forceLeftToRight
        }
//        UINavigationBar.appearance().backgroundColor = UIColor(named: "MainColor")
//        UINavigationBar.appearance().tintColor = .black
//        UINavigationBar.appearance().barTintColor = .orange
//        UINavigationBar.appearance().tintColor = .black
//        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
//        UINavigationBar.appearance().isTranslucent = false
        // To change background colour.
        UINavigationBar.appearance().barTintColor = .black
        // To change colour of tappable items.
        UINavigationBar.appearance().tintColor = UIColor(named: "MainColor")!
        // To apply textAttributes to title i.e. colour, font etc.
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor.black ]
        // To control navigation bar's translucency.
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.setColors(background: UIColor(named: "MainColor")!, text: .black)
        
        

//        UINavigationBar.appearance().barStyle = .default


        
//        let mainwindow = (UIApplication.shared.delegate?.window!)!
//        mainwindow.backgroundColor = UIColor(hue: 0.6477, saturation: 0.6314, brightness: 0.6077, alpha: 0.8)
//        AppDelegate.shared.setAppearance()
    }
}
