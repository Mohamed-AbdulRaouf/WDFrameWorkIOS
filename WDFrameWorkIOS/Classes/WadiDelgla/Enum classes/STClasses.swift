//
//  STClasses.swift
//  STDobites
//
//  Created by SimpleTouch on 9/10/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
import UIKit
class STReusableDTO {
    var image : UIImage
    var title: String
    var subTitle: String
    var buttonTitle: String
    init(_ image : UIImage,_ title : String,_ subTitle: String,_ buttonTitle : String) {
        self.image = image
        self.title = title
        self.subTitle = subTitle
        self.buttonTitle = buttonTitle
    }
}
