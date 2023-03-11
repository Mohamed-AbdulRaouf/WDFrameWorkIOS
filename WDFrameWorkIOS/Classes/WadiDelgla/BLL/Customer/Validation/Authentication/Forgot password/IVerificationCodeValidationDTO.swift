//
//  IVerificationCodeValidationDTO.swift
//  BLL
//
//  Created by SimpleTouch on 10/16/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol IVerificationCodeValidationDTOBLL : IBaseValidationDTOBLL{
    var msgPhoneNumberError : Observable<String?> { get  set}
}
