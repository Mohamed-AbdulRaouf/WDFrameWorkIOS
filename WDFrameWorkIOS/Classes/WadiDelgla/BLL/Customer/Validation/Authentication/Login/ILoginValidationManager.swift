//
//  ILoginValidationManager.swift
//  BLL
//
//  Created by SimpleTouch on 10/9/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
////import DAL
public protocol ILoginValidationManagerBLL  {
    var errorViewModel: ILoginValidationDTOBLL? { get set }
    func validateMobileNumber(string: String) -> Bool
    func validatePassword(string: String) -> Bool
}
extension ILoginValidationManagerBLL where Self: IUserValidationManagerBLL {
   
    public typealias T = ILoginDTODAL
    
    public typealias M = ILoginValidationDTOBLL
    public func validate(model: ILoginDTODAL) -> Bool {
        fatalError("Must override this function")
    }
}
