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

        let bll_bundle = Bundle(identifier: "com.simpletouch.BLL")!
         print("URL BATH -> \(String(describing: bll_bundle.bundlePath))")
//        defer {
            object_setClass(Bundle.main, AnyLanguageBundle.self)
            object_setClass(bll_bundle, AnyLanguageBundle.self)
            


//        }
        
        if language == "ar" {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            UINavigationBar().semanticContentAttribute = .forceRightToLeft
        } else {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UINavigationBar().semanticContentAttribute = .forceLeftToRight
        }
        
        objc_setAssociatedObject(Bundle.main, &bundleKey,    Bundle.main.path(forResource: language, ofType: "lproj"), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(bll_bundle, &bundleKey,   bll_bundle.path(forResource: language, ofType: "lproj"), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)

    }
}
