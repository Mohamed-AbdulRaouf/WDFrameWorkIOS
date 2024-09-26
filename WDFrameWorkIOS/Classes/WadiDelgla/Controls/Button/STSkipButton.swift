//
//  STSkipButton.swift
//  STDobites
//
//  Created by SimpleTouch on 10/16/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
@IBDesignable
final class STSkipButton: UIButton {

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
        self.setTitle(R.string.localizable.skip(), for: .normal)
        self.setTitleColor(.white, for: .normal)
    }

}
