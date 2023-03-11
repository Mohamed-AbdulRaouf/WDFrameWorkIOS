//
//  ICartValidationDTO.swift
//  BLL
//
//  Created by SimpleTouch on 11/17/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol ICartValidationDTOBLL : IBaseValidationDTOBLL {
    var msgError : Observable<String?> { get  set}
 
}
