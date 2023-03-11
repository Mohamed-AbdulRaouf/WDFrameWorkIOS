//
//  ResetPasswordValidationDTO.swift
//  BLL
//
//  Created by SimpleTouch on 10/16/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public class ResetPasswordValidationDTO : NSObject,IResetPasswordValidationDTOBLL{
    
    public var msgVerifyCodeError = Observable<String?>(nil)
    public var msgPasswordError = Observable<String?>(nil)
    public var msgConfirmPassowrdError = Observable<String?>(nil)

}
