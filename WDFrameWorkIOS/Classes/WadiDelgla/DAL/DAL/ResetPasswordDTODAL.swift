//
//  ResetPasswordDTO.swift
//  DAL
//
//  Created by SimpleTouch on 10/16/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public  class ResetPasswordDTODAL : BaseUserDTODAL, IResetPasswordDTODAL{
    public var brandId = Observable<Int?>(nil)
    public var password = Observable<String?>(nil)
    public var confirmPassword = Observable<String?>(nil)
    public var countryId: Observable<String?> = Observable<String?>(nil)
    public override init(){}
}
