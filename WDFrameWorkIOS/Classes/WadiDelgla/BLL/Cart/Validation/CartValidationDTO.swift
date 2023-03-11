//
//  CartValidationDTO.swift
//  BLL
//
//  Created by SimpleTouch on 11/17/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public class CartValidationDTOBLL : NSObject,ICartValidationDTOBLL{
 public var msgError: Observable<String?> = Observable<String?>(nil)
}
