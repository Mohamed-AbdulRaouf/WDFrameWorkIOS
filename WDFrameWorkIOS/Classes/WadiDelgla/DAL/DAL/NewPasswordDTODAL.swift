//
//  NewPasswordDTO.swift
//  DAL
//
//  Created by SimpleTouch on 10/21/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public  class NewPasswordDTODAL : BaseUserDTODAL, INewPasswordDTODAL{
    public var currentPassword: Observable<String?> = Observable<String?>(nil)
    
    public var oldPassword = Observable<String?>(nil)
    
    public var newPassword = Observable<String?>(nil)
    
    public var confirmPassword = Observable<String?>(nil)
    
   
    public override init(){}
}
