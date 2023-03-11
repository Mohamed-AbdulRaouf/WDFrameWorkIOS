//
//  IChangePasswordValidationManager.swift
//  BLL
//
//  Created by SimpleTouch on 10/21/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
////import DAL
public protocol IChangePasswordValidationManagerBLL  {
    var errorViewModel: IChangePasswordValidationDTOBLL? { get set }
    func validateOldPassword(string: String,currentPassowrd:String) -> Bool
    func validateNewPassword(string: String) -> Bool
    func validateConfirmPassword(password: String,newpassword: String) -> Bool
}
extension IChangePasswordValidationManagerBLL where Self: IValidationManagerBLL {
    
    public typealias T = INewPasswordDTODAL
    
    public typealias M = IChangePasswordValidationDTOBLL
    public func validate(model: INewPasswordDTODAL) -> Bool {
        fatalError("Must override this function")
    }
}
