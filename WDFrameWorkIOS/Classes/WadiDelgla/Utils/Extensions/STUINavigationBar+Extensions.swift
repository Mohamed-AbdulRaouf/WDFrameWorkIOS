//
//  STUINavigationBar+Extensions.swift
//  STDobites
//
//  Created by SimpleTouch on 10/22/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import UIKit
extension UINavigationBar {
    
    /// SwifterSwift: Set Navigation Bar title, title color and font.
    ///
    /// - Parameters:
    ///   - font: title font
    ///   - color: title text color (default is .black).
   static func setTitleFont(_ font: UIFont, color: UIColor = .black) {
        var attrs = [NSAttributedString.Key: Any]()
        attrs[.font] = font
        attrs[.foregroundColor] = color
        UINavigationBar.appearance().titleTextAttributes = attrs
    }
    
    
    /// SwifterSwift: Set navigationBar background and text colors
    ///
    /// - Parameters:
    ///   - background: backgound color
    ///   - text: text color
    static func setColors(background: UIColor, text: UIColor) {
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = background
        UINavigationBar.appearance().tintColor = background
        UINavigationBar.appearance().barTintColor = background
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor:text]
        UINavigationBar.appearance().barStyle = .blackOpaque
//        if let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView {
//            statusBar.setValue(UIColor.white, forKey: "foregroundColor")
//            statusBar.setValue(UIColor.init(hexString: "#bb0000"), forKey: "backgroundColor")
//        }
//        UIApplication.shared.statusBarView?.backgroundColor = UIColor.init(hexString: "#bb0000")
        
        
        
    }
}
