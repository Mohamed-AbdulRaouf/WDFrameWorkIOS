//
//  IResetPasswordValidationManager.swift
//  BLL
//
//  Created by SimpleTouch on 10/16/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
////import DAL
public protocol IResetPasswordValidationManagerBLL  {
    var errorViewModel: IResetPasswordValidationDTOBLL? { get set }
//    func validateVerificationCode(string: String) -> Bool
    func validatePassword(string: String) -> Bool
    func validateConfirmPassword(password: String,newpassword: String) -> Bool

}
extension IResetPasswordValidationManagerBLL where Self: IValidationManagerBLL {
    
    public typealias T = IResetPasswordDTODAL
    
    public typealias M = IResetPasswordValidationDTOBLL
    public func validate(model: IResetPasswordDTODAL) -> Bool {
        fatalError("Must override this function")
    }
}
