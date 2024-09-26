//
//  RegisterValidationDTO.swift
//  BLL
//
//  Created by SimpleTouch on 10/8/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public class RegisterValidationDTOBLL : NSObject,IRegisterValidationDTOBLL{
    public var msgPhoneNumberError = Observable<String?>(nil)
    
    public var msgFirstNAmeError = Observable<String?>(nil)
    
    public var msgLastNameError = Observable<String?>(nil)
    
    public var msgEmailError = Observable<String?>(nil)
    
    public var msgPasswordError = Observable<String?>(nil)
    
    public var msgConfirmPasswordError: Observable<String?> = Observable<String?>(nil)
    
}
