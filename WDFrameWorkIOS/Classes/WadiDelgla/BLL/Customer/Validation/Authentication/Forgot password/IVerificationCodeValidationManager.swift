//
//  IVerificationCodeValidationManager.swift
//  BLL
//
//  Created by SimpleTouch on 10/16/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
////import DAL
public protocol IVerificationCodeValidationManagerBLL  {
    var errorViewModel: IVerificationCodeValidationDTOBLL? { get set }
    func validateMobileNumber(string: String,hintNumber: String) -> Bool
}
extension IVerificationCodeValidationManagerBLL where Self: IValidationManagerBLL {
    
    public typealias T = IAuthPhoneNumberDTODAL
    
    public typealias M = IVerificationCodeValidationDTOBLL
    public func validate(model: IAuthPhoneNumberDTODAL) -> Bool {
        fatalError("Must override this function")
    }
}
