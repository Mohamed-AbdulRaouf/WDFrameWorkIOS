//
//  LoginUNamePassCountryValidationDTO.swift
//  BLL
//
//  Created by SimpleTouch on 11/24/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public class LoginUNamePassCountryValidationDTOBLL : NSObject,ILoginUNamePassCountryValidationDTOBLL{
    public var msgPhoneNumberError = Observable<String?>(nil)
    public var msgPasswordError = Observable<String?>(nil)
    
}
