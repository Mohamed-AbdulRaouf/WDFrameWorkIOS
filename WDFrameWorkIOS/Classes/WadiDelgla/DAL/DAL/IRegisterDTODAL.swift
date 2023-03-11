//
//  IRegisterDTO.swift
//  DAL
//
//  Created by SimpleTouch on 10/3/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol  IRegisterDTODAL:AnyObject  {
    var id: Observable<Int?> {get set}
    var code: Observable<String?> { get set }
    var firstName: Observable<String?> { get set }
    var lastName: Observable<String?> { get set }
    var mobile: Observable<String?> { get set }
    var email: Observable<String?> { get set }
    var password: Observable<String?> { get set }
    var gender: Observable<String?> { get set }
    var shareCode: Observable<String?> { get set }
    var brandId: Observable<Int?> {get set}
    var countryId: Observable<String?> { get set }
    var dialCode: Observable<String?> { get set }
    var confirmPassword: Observable<String?> { get set }
    var membershipNumber: Observable<String?> { get set }
}
