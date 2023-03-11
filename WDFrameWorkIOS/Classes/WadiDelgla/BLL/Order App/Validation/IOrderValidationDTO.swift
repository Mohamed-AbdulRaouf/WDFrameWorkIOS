//
//  IOrderValidationDTO.swift
//  BLL
//
//  Created by SimpleTouch on 11/21/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol IOrderValidationDTOBLL: IBaseValidationDTOBLL {
    var msgError : Observable<String?> { get  set}
    var msgEmptyUserAddressError: Observable<Bool?> {get set}
    
}
