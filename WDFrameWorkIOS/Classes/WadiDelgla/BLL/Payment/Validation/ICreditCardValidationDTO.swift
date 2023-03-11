//
//  ICreditCardValidationDTO.swift
//  BLL
//
//  Created by SimpleTouch on 8/6/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol ICreditCardValidationDTOBLL : IBaseValidationDTOBLL { 
    var msgCardHolderNameError : Observable<String?> { get  set}
    var msgCardNumberError : Observable<String?> { get  set}
    var msgCardExpiryDateError : Observable<String?> { get set }
    var msgCardCVVError : Observable<String?> { get set }
}
