//
//  UIHelper.swift
//  SimpleTouch
//
//  Created by SimpleTouch on 14/5/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import UIKit
public extension UIViewController {
    func addShadowToNavBar() {
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 4.0
        self.navigationController?.navigationBar.layer.shadowOpacity = 1.0
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.backgroundColor = COLOR_PRIMARY_TEXT
    }
    
}
public extension UILabel {
    func textDropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 1, height: 2)
    }
}
public extension UIButton
{
    func alignTextUnderImage(spacing: CGFloat = 6.0, in Language: String = "en")
    {
        //when the selected language is English
        if Language == "en" {
            guard let image = imageView?.image, let label = titleLabel,
                let string = label.text else { return }
            
            titleEdgeInsets = UIEdgeInsets(top: spacing, left: -image.size.width, bottom: -image.size.height, right: 0.0)
            let titleSize = string.size(withAttributes: [NSAttributedString.Key.font: label.font])
            imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0.0, bottom: 0.0, right: -titleSize.width)
        } else {
            //When selecting a right to left language. For example, Arabic
            guard let image = imageView?.image, let label = titleLabel,
                let string = label.text else { return }
            
            titleEdgeInsets = UIEdgeInsets(top: spacing, left: 0, bottom: -image.size.height, right: -image.size.width)
            let titleSize = string.size(withAttributes: [NSAttributedString.Key.font: label.font])
            imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: -titleSize.width, bottom: 0.0, right: 0)
        }
    }
}
