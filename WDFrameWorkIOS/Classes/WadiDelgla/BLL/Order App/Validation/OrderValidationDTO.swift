//
//  OrderValidationDTO.swift
//  BLL
//
//  Created by SimpleTouch on 11/21/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public class OrderValidationDTOBLL : NSObject,IOrderValidationDTOBLL{
    public var msgError: Observable<String?> = Observable<String?>(nil)
    public var msgEmptyUserAddressError: Observable<Bool?> = Observable<Bool?>(nil)
}
