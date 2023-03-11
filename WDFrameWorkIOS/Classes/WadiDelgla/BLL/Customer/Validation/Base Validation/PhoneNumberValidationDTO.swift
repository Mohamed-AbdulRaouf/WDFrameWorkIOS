//
//  PhoneNumberValidationDTO.swift
//  BLL
//
//  Created by SimpleTouch on 1/30/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public class PhoneNumberValidationDTOBLL : NSObject, IPhoneNumberValidationDTOBLL{
    public var msgPasswordError = Observable<String?>(nil)
    
    public var msgPhoneNumberError = Observable<String?>(nil)
}

