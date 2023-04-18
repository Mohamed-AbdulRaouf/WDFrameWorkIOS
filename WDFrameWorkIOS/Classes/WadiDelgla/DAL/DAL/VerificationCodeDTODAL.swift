//
//  VerificationCodeDTO.swift
//  DAL
//
//  Created by SimpleTouch on 10/16/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public  class VerificationCodeDTODAL : BaseUserDTODAL, IVerificationCodeDTODAL{
    public var mobile: Observable<String?> = Observable<String?>(nil)
    public var brandId: Observable<Int?> = Observable<Int?>(nil)
    public var code = Observable<String?>(nil)
    public var verificationId: Observable<String?> = Observable<String?>(nil)
    public override init(){}
}
