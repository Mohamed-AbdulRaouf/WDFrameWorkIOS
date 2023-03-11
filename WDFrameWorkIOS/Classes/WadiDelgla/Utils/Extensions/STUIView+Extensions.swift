//
//  STUIView.swift
//  STDobites
//
//  Created by SimpleTouch on 10/17/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
import SVProgressHUD
extension IBaseViewModel{
    func showHud(_ message: String) {
       doOnMain {
        SVProgressHUD.show(withStatus: message)
        }
    }
    
    func showHud() {
        doOnMain {
            SVProgressHUD.setDefaultMaskType(.custom)
            SVProgressHUD.setBackgroundLayerColor(.clear) // your custom color
            SVProgressHUD.show()
        }
    }
    
    func hideHUD() {
        doOnMain { SVProgressHUD.dismiss() }
    }
   
}
extension UIView {
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
