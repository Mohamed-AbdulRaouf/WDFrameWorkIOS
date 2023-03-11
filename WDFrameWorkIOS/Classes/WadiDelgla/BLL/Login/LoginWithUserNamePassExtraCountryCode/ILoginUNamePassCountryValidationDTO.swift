//
//  ILoginUNamePassCountryValidationDTO.swift
//  BLL
//
//  Created by SimpleTouch on 11/24/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol ILoginUNamePassCountryValidationDTOBLL : IBaseValidationDTOBLL{ 
    var msgPhoneNumberError : Observable<String?> { get  set}
    var msgPasswordError: Observable<String?> { get  set}
}
