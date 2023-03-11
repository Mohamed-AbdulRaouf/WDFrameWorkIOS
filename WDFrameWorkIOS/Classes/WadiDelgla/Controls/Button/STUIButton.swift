//
//  STUIButton.swift
//  SimpleTouch
//
//  Created by SimpleTouch on 10/5/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import UIKit
@IBDesignable
final class STUIButton: UIButton {
    
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
        self.backgroundColor = COLOR_BUTTON
        self.setTitleColor(COLOR_BUTTON_TEXT, for: .normal)
        self.titleLabel?.font = FONT_PRIMARY_BUTTON
    }
    
}
