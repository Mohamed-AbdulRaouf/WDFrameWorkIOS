//
//  IPhoneNumberValidationManager.swift
//  BLL
//
//  Created by SimpleTouch on 1/30/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
////import DAL
public protocol IPhoneNumberValidationManagerBLL  {
    var errorViewModel: IPhoneNumberValidationDTOBLL? { get set }
    func validateMobileNumber(string: String) -> Bool
}
extension IPhoneNumberValidationManagerBLL where Self: IValidationManagerBLL {
    
    public typealias T = String
    
    public typealias M = IPhoneNumberValidationDTOBLL
    public func validate(model: String) -> Bool {
        fatalError("Must override this function")
    }
}
