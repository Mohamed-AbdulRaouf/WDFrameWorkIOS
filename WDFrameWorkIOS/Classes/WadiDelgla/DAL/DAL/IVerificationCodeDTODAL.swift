//
//  IVerificationCodeDTO.swift
//  DAL
//
//  Created by SimpleTouch on 10/16/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol  IVerificationCodeDTODAL: AnyObject {
    var code: Observable<String?> { get set }
    var mobile: Observable<String?> { get set }
    var brandId: Observable<Int?> { get set }
    var verificationId: Observable<String?> { get set }
}
