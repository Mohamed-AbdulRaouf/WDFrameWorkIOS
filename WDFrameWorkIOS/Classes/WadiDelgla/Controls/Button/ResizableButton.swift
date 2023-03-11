//
//  UIButton+Extensions.swift
//  DoBites
//
//  Created by SimpleTouch on 6/9/19.
//  Copyright © 2019 Nermeen Mohdamed. All rights reserved.
//

import UIKit

class ResizableButton: UIButton {
    override var intrinsicContentSize: CGSize {
        let labelSize = titleLabel?.sizeThatFits(CGSize(width: frame.width, height: .greatestFiniteMagnitude)) ?? .zero
        let desiredButtonSize = CGSize(width: labelSize.width + titleEdgeInsets.left + titleEdgeInsets.right, height: labelSize.height + titleEdgeInsets.top + titleEdgeInsets.bottom)
        
        return desiredButtonSize
    }
}
