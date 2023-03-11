//
//  IAuthPhoneNumberDTO.swift
//  DAL
//
//  Created by SimpleTouch on 1/27/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol  IAuthPhoneNumberDTODAL:AnyObject {
    var mobile: Observable<String?> { get set }
    var countryId: Observable<String?> { get set }
    var verificationId: Observable<String?> { get set }
    var verificationCode: Observable<String?> { get set }
    var dialCode:  Observable<String?> { get set }

}
