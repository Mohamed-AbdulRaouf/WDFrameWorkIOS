//
//  STUISecondaryButton.swift
//  SimpleTouch
//
//  Created by SimpleTouch on 10/5/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import UIKit
@IBDesignable
final class STUISecondaryButton: UIButton {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpView()
    }
    
    func setUpView(){
        self.backgroundColor = UIColor.COLOR_SECONDARY_BUTTON_BG
        self.setTitleColor(UIColor.COLOR_SECONDARY_BUTTON_TEXT_COLOR, for: .normal)
    }
    
}
