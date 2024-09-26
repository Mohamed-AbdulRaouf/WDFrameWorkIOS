//
//  STBundle+Extensions.swift
//  STDobites
//
//  Created by SimpleTouch on 10/22/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//
import Foundation
import UIKit

var bundleKey: UInt8 = 0

class AnyLanguageBundle: Bundle {
    
    override func localizedString(forKey key: String,
                                  value: String?,
                                  table tableName: String?) -> String {
        
        guard let path = objc_getAssociatedObject(self, &bundleKey) as? String,
            let bundle = Bundle(path: path) else {
                
                return super.localizedString(forKey: key, value: value, table: tableName)
        }
        
        return bundle.localizedString(forKey: key, value: value, table: tableName)
    }
}

extension Bundle {
    class func setLanguage(_ language: String) {
        if language == "ar" {
            SetAppLanguage.shared.setLanguage(languageCode: "ar")
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            UINavigationBar().semanticContentAttribute = .forceRightToLeft
        } else {
            SetAppLanguage.shared.setLanguage(languageCode: "en")
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UINavigationBar().semanticContentAttribute = .forceLeftToRight
        }
    }
}
