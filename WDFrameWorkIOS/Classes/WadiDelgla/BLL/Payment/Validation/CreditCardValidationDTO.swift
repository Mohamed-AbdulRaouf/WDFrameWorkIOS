//
//  CreditCardValidationDTO.swift
//  BLL
//
//  Created by SimpleTouch on 8/6/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public class CreditCardValidationDTOBLL : NSObject,ICreditCardValidationDTOBLL{
    public var msgCardHolderNameError: Observable<String?> = Observable<String?>(nil)
    
    public var msgCardNumberError: Observable<String?> = Observable<String?>(nil)
    
    public var msgCardExpiryDateError: Observable<String?> = Observable<String?>(nil)
    
    public var msgCardCVVError: Observable<String?> = Observable<String?>(nil)
}
