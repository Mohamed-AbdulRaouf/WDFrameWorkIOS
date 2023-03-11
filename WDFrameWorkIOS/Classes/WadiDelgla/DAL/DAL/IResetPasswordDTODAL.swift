//
//  IResetPasswordDTO.swift
//  DAL
//
//  Created by SimpleTouch on 10/16/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol  IResetPasswordDTODAL:AnyObject {
    var mobile: Observable<String?> { get set }
    var password: Observable<String?> { get set }
    var confirmPassword: Observable<String?> { get set }
    var brandId: Observable<Int?> { get set }
    var countryId: Observable<String?> { get set }
}
