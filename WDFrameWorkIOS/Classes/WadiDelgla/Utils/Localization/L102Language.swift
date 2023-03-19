//
//  L102Language.swift
//  ProjectMVC
//
//  Created by Mohamed Abdul-Raouf on 05/01/2022.
//

import UIKit

let APPLE_LANGUAGE_KEY = "AppleLanguages"

class L102Language: NSObject {

    class var isRTL: Bool {
        return L102Language.currentAppleLanguage() == "ar"
    }
    
    @objc class func currentAppleLanguage() -> String {
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        if current == "ar" {
            return current
        }
        return "en"
    }
    
    @objc class func setAppleLAnguageTo(lang: String) {
        let userdef = UserDefaults.standard
        userdef.set([lang,currentAppleLanguage()], forKey: APPLE_LANGUAGE_KEY)
        userdef.synchronize()
    }

    class func currentAppleLanguageFull() -> String {
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        return current
    }

    class func switchLanguage() {
        if L102Language.currentAppleLanguage() == "en" {
            L102Language.setAppleLAnguageTo(lang: "ar")
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        } else {
            L102Language.setAppleLAnguageTo(lang: "en")
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
    }
    
    class func isCurrentLanguageArabic() -> Bool {
        return L102Language.currentAppleLanguage() == "ar"
    }
}
