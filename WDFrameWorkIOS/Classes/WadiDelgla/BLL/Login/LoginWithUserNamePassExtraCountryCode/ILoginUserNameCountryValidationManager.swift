//
//  ILoginUserNameCountryValidationManager.swift
//  BLL
//
//  Created by SimpleTouch on 11/24/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
////import DAL
public protocol ILoginUserNameCountryValidationManagerBLL  {
    var errorViewModel: ILoginUNamePassCountryValidationDTOBLL? { get set }
    func validateMobileNumber(string: String) -> Bool
    func validatePassword(string: String) -> Bool
}
extension ILoginUserNameCountryValidationManagerBLL where Self: IUserValidationManagerBLL {
   
    public typealias T = IUserNameWithCountryLoginModelDAL
    
    public typealias M = ILoginUNamePassCountryValidationDTOBLL
    public func validate(model: IUserNameWithCountryLoginModelDAL) -> Bool {
        fatalError("Must override this function")
    }
}
