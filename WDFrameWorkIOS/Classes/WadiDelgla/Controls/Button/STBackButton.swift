//
//  STBackButton.swift
//  DoBites
//
//  Created by SimpleTouch on 8/6/19.
//  Copyright © 2019 Nermeen Mohdamed. All rights reserved.
//

 import UIKit

@IBDesignable
class STBackButton: UIButton {
 
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        self.setImage(LocalizationSystem.sharedInstance.isCurrentLanguageArabic() ? R.image.ic_back_ar() : R.image.ic_back(), for: .normal)
    }
}

