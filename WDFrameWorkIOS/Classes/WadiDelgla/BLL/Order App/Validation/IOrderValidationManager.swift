//
//  IOrderValidationManager.swift
//  BLL
//
//  Created by SimpleTouch on 11/21/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
////import DAL
public protocol IOrderValidationManagerBLL  {
    var errorViewModel: IOrderValidationDTOBLL? { get set }
//    func validateUserAddressId(userAddressId: Int) -> Bool
}
extension IOrderValidationManagerBLL where Self: IValidationManagerBLL { 
    public typealias T = ISTCheckoutOrderDTODAL
    
    public typealias M = IOrderValidationDTOBLL
    public func validate(model: ISTCheckoutOrderDTODAL) -> Bool {
        fatalError("Must override this function")
    }
    
}
