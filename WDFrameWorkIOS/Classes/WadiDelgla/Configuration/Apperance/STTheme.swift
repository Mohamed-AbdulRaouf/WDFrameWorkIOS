//
//  STTheme.swift
//  BabElHara
//
//  Created by SimpleTouch on 12/29/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//
import UIKit
extension UIColor {
    static var COLOR_HOME_ACTIONS: UIColor {
//         return UIColor.init(hexString: "caad8c")!
        return UIColor(red: 253.0 / 255.0, green: 215.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
     }
     static var COLOR_SECONDARY_BUTTON_BG: UIColor {
         return COLOR_ACCENT
     }
     static var COLOR_SECONDARY_BUTTON_TEXT_COLOR: UIColor {
      return UIColor.black
     }
     static var COLOR_SECONDARY_TINT_IMAGE: UIColor {
           return COLOR_ACCENT
       }
     static var locationTitleTextColor : UIColor{
         return COLOR_ACCENT
     }
     static  var locationBorderColor: UIColor {
         return .white
     }

     // login - register colors
     static var signInUpTitleTextColor : UIColor {
         return COLOR_ACCENT
     }
     static var signInUpPlaceholderTextColor: UIColor {
         return COLOR_ACCENT
     }
     static var signInUpBorderColor: UIColor {
         return .white
     }
     static var genderStrokeColor : UIColor {
         return COLOR_ACCENT
     }
     static var genderCircleColor: UIColor
     {
         return COLOR_ACCENT
     }
     static var genderTextColor: UIColor {
         return COLOR_ACCENT
     }
    static var statusBarBackgroundColor: UIColor {
          return COLOR_ACCENT
      }
      
}
let STATUS_BAR_STYLE : UIStatusBarStyle = UIStatusBarStyle.darkContent
