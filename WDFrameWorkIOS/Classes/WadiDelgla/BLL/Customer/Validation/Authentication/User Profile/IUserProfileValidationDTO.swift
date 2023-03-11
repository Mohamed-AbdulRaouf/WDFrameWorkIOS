//
//  IUserProfileValidationDTO.swift
//  BLL
//
//  Created by SimpleTouch on 10/21/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol IUserProfileValidationDTOBLL : IBaseValidationDTOBLL{ 
    var msgFirstNameError: Observable<String?> { get  set}
    var msgLastNameError: Observable<String?> { get  set}
    var msgEmailError : Observable<String?> { get  set}
}
