//
//  UserProfileValidationDTO.swift
//  BLL
//
//  Created by SimpleTouch on 10/21/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public class UserProfileValidationDTOBLL : NSObject,IUserProfileValidationDTOBLL{
    public var msgFirstNameError: Observable<String?> = Observable<String?>(nil)
    
    public var msgLastNameError: Observable<String?> = Observable<String?>(nil)
    
    public var msgEmailError: Observable<String?> = Observable<String?>(nil)
    
    public var msgBirthDateError: Observable<String?> = Observable<String?>(nil)
    
    public var msgGenderError: Observable<String?> = Observable<String?>(nil)
    
    public var msgPhoneNumberError = Observable<String?>(nil)
    
}
