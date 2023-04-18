//
//  AuthPhoneNumberDTO.swift
//  DAL
//
//  Created by SimpleTouch on 1/27/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public  class AuthPhoneNumberDTODAL : BaseUserDTODAL, IAuthPhoneNumberDTODAL{
    public var mobile: Observable<String?> = Observable<String?>(nil)
    
    public var countryId: Observable<String?> = Observable<String?>(nil)
    
    public var verificationId: Observable<String?> = Observable<String?>(nil)
    
    public var verificationCode: Observable<String?> = Observable<String?>(nil)
    
    public var dialCode: Observable<String?> = Observable<String?>(nil)
    
    public override init(){}
}
