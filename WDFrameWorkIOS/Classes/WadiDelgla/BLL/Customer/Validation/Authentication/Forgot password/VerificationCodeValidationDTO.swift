//
//  VerificationCodeValidationDTO.swift
//  BLL
//
//  Created by SimpleTouch on 10/16/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public class VerificationCodeValidationDTOBLL : NSObject,IVerificationCodeValidationDTOBLL{
    public var msgPhoneNumberError = Observable<String?>(nil)
    
}
