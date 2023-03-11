//
//  LoginValidationDTO.swift
//  BLL
//
//  Created by SimpleTouch on 10/9/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public class LoginValidationDTOBLL : NSObject,ILoginValidationDTOBLL{
    public var msgPhoneNumberError = Observable<String?>(nil)
    public var msgPasswordError = Observable<String?>(nil)
    
}
