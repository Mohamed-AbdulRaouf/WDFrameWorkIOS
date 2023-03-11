//
//  IUserProfileValidationManager.swift
//  BLL
//
//  Created by SimpleTouch on 10/21/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
////import DAL
public protocol IUserProfileValidationManagerBLL  {
    var errorViewModel: IUserProfileValidationDTOBLL? { get set }
    func validateFirstName(string: String) -> Bool
    func validateLastName(string: String) -> Bool
    func validateEmail(string: String) -> Bool
}
extension IUserProfileValidationManagerBLL where Self: IValidationManagerBLL {
    
    public typealias T = IUserDTODAL
    
    public typealias M = IUserProfileValidationDTOBLL
    public func validate(model: IUserDTODAL) -> Bool {
        fatalError("Must override this function")
    }
}
