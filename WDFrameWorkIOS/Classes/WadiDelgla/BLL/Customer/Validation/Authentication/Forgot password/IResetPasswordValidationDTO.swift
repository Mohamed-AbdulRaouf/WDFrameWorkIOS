//
//  IResetPasswordValidationDTO.swift
//  BLL
//
//  Created by SimpleTouch on 10/16/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol IResetPasswordValidationDTOBLL : IBaseValidationDTOBLL{ 
    var msgVerifyCodeError : Observable<String?> { get set}
    var msgPasswordError : Observable<String?> { get set}
    var msgConfirmPassowrdError : Observable<String?> { get set}
}
