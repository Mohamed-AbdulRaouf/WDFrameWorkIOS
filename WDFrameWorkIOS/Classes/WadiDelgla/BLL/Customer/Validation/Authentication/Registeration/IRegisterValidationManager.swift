//
//  IRegisterValidationManager.swift
//  BLL
//
//  Created by SimpleTouch on 10/8/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
////import DAL
public protocol IRegisterValidationManagerBLL  {
    var errorViewModel: IRegisterValidationDTOBLL? { get set }
    func validateMobileNumber(string: String) -> Bool
    func validateFirstNameString(string: String) -> Bool
    func validateLastNameString(string: String) -> Bool
    func validateEmailId(string: String) -> Bool
    func validatePassword(string: String) -> Bool
    func validateConfirmPassword(password: String, confirmedPassword: String) -> Bool 
}
extension IRegisterValidationManagerBLL where Self: IValidationManagerBLL {
    public typealias T = IRegisterDTODAL
    
    public typealias M = IRegisterValidationDTOBLL
    public func validate(model: IRegisterDTODAL) -> Bool {
        fatalError("Must override this function")
    }
    
}
