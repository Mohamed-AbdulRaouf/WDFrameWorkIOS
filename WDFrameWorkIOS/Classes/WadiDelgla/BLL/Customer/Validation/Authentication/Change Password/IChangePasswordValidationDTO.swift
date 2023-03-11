//
//  IChangePasswordValidationDTO.swift
//  BLL
//
//  Created by SimpleTouch on 10/21/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol IChangePasswordValidationDTOBLL : IBaseValidationDTOBLL{
    var msgOldPasswordError: Observable<String?> { get  set}
    var msgNewPasswordError: Observable<String?> { get  set}
    var msgConfirmPasswordError : Observable<String?> { get  set}
}
