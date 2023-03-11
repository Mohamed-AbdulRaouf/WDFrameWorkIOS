//
//  STBundle+Extensions.swift
//  STDobites
//
//  Created by SimpleTouch on 10/22/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//
import Foundation
import UIKit

var bundleKeyBLL: UInt8 = 0

class AnyLanguageBundleBLL: Bundle {
    
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
    /// This Function To set selected Language For BLL Bundle 
    ///
    /// - Parameter language: The Choosen Language for App
    class func setLanguageBLL(_ language: String) {
        defer {
            object_setClass(Bundle.main, AnyLanguageBundleBLL.self)
        }
        
        objc_setAssociatedObject(Bundle.main, &bundleKey,    Bundle.main.path(forResource: language, ofType: "lproj"), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
