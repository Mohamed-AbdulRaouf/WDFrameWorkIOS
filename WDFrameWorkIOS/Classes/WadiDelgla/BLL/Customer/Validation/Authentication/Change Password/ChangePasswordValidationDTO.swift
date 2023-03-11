//
//  ChangePasswordValidationDTO.swift
//  BLL
//
//  Created by SimpleTouch on 10/21/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public class ChangePasswordValidationDTOBLL : NSObject,IChangePasswordValidationDTOBLL{
    public var msgOldPasswordError: Observable<String?> = Observable<String?>(nil)
    
    public var msgNewPasswordError: Observable<String?> = Observable<String?>(nil)
    
    public var msgConfirmPasswordError: Observable<String?> = Observable<String?>(nil)
    
}
