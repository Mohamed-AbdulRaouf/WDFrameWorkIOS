//
//  STUnderLineLabel.swift
//  STDobites
//
//  Created by SimpleTouch on 11/14/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import UIKit
class STUnderlinedLabel: UILabel {
    
    override var text: String? {
        didSet {
            guard let text = text else { return }
            let textRange = NSMakeRange(0, text.count)
            let attributedText = NSMutableAttributedString(string: text)
#if swift(>=5.0)
print("Running Swift 5.0 or later")
            attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange)
#else
print("Running old Swift")
            attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.styleSingle.rawValue, range: textRange)

#endif
            // Add other attributes if needed
            self.attributedText = attributedText
        }
    }
}
