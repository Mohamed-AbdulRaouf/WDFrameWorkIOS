//
//  ILoginValidationDTO.swift
//  BLL
//
//  Created by SimpleTouch on 10/9/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol ILoginValidationDTOBLL : IBaseValidationDTOBLL{ 
    var msgPhoneNumberError : Observable<String?> { get  set}
    var msgPasswordError: Observable<String?> { get  set}
}
