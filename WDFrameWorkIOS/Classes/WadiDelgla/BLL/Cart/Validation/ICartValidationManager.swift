//
//  ICartValidationManager.swift
//  BLL
//
//  Created by SimpleTouch on 11/17/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
////import DAL
public protocol ICartValidationManagerBLL  {
    var errorViewModel: ICartValidationDTOBLL? { get set }
    func validateSize(_ sizes: [IMenuSizeDTODAL]) -> Bool
    func validateChoiceGroupsMinMax(_ selectedSize: IMenuSizeDTODAL) -> Bool
}
extension ICartValidationManagerBLL where Self: IValidationManagerBLL {
    public typealias T = IMenuSizeDTODAL
    
    public typealias M = ICartValidationDTOBLL
    public func validate(model: IMenuSizeDTODAL) -> Bool {
        fatalError("Must override this function")
    }
    
}
