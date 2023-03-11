//
//  STErrorTextField.swift
//  STDobites
//
//  Created by SimpleTouch on 10/10/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
import Bond
class STErrorTextField: UITextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var error : Observable<String?>?  {
        didSet{
            self.setError(error?.value, show: (error?.value != nil && error?.value != "" ))
        }
    }

}
