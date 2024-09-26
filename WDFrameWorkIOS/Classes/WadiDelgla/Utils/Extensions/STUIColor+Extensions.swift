//
//  STUIColor+Extensions.swift
//  STDobites
//
//  Created by SimpleTouch on 10/7/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
extension UIColor{
    
    @nonobjc class var STGray: UIColor {
        return UIColor(red: 77.0 / 255.0, green: 77.0 / 255.0, blue: 77.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var STRed: UIColor {
        return UIColor(red: 230.0 / 255.0, green: 79.0 / 255.0, blue: 79.0 / 255.0, alpha: 1.0)
        
    }
    
    @nonobjc class var STYellow: UIColor {
        return UIColor.init(hexString: "#FFD02A")!
    }
    
    @nonobjc class var MainColorApp: UIColor {
        return UIColor.init(hexString: "#FDD72E")!
    }
    
}
