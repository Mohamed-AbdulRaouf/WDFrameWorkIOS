//
//  OrderValidationManager.swift
//  BLL
//
//  Created by SimpleTouch on 11/21/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
////import DAL

public class OrderValidationManagerBLL : IValidationManagerBLL{
    
    
    public var errorViewModel: IOrderValidationDTOBLL?
    
    required public init(errorModel: IOrderValidationDTOBLL){
        self.errorViewModel = errorModel
    }
    
    
    public  func validate(model: ISTCheckoutOrderDTODAL) -> Bool {
        return true
//        if !validateUserAddressId(userAddressId: model.selectedAddressId){
//            return false
//         }else{
//             return true
//        }
    }
    
}
// Fields to be validated
extension OrderValidationManagerBLL : IOrderValidationManagerBLL {
     //MARK: validate Order UserAddressID
  
    
}
