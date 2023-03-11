//
//  STUIImageView+Extensions.swift
//  STDobites
//
//  Created by SimpleTouch on 10/10/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
import FontAwesome_swift
extension UIImage {
    static func getFontAwaseomImage(fontName : String,imageSize: CGSize,_ color : UIColor = COLOR_ACCENT) -> UIImage{
        var iconNameArr = fontName.split{$0 == " "}.map(String.init)
        if iconNameArr.count == 2 {
            let type: String = iconNameArr[0]
            let name: String? = iconNameArr.count > 1 ? iconNameArr[1] : nil
            return self.fontAwesomeIcon(code: name ?? "", style: FontAwesomeStyle.getFontAwesomeStyle(type: type), textColor: color, size: imageSize) ?? UIImage()
            
        }else{
            return  UIImage.fontAwesomeIcon(name: .layerGroup, style: .solid, textColor: color, size: imageSize)
            
        }
    }
    
}
extension FontAwesomeStyle {
    static func getFontAwesomeStyle(type :String) -> FontAwesomeStyle {
        switch type {
        case "fos":
            return FontAwesomeStyle.solid
        case "far":
            return FontAwesomeStyle.regular
        case "fal":
            return FontAwesomeStyle.light
        default:
            return FontAwesomeStyle.solid
        }
    }
}
extension UIImageView {

    func makeRounded() {

        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
