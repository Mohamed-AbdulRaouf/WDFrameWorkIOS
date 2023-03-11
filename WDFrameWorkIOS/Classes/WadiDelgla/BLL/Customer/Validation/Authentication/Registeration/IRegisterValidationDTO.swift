//
//  IRegisterValidationDTO.swift
//  BLL
//
//  Created by SimpleTouch on 10/8/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol IRegisterValidationDTOBLL : IBaseValidationDTOBLL { 
    var msgPhoneNumberError : Observable<String?> { get  set}
    var msgFirstNAmeError : Observable<String?> { get  set}
    var msgLastNameError : Observable<String?> { get set }
    var msgEmailError : Observable<String?> { get set }
    var msgPasswordError: Observable<String?> { get  set}
    var msgConfirmPasswordError : Observable<String?> { get  set}

}
