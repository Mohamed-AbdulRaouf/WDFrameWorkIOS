//
//  IAddressValidationManager.swift
//  BLL
//
//  Created by Nermeen Mohamed on 11/3/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
////import DAL
public protocol IAddressValidationManagerBLL  {
    var errorViewModel: IAddressValidationDTOBLL? { get set }
    
    func validateBuildingNo(string: String) -> Bool
    func validateStreetName(string: String) -> Bool
    func validateFloorNo(string: String) -> Bool
    func validateArea(string: String) -> Bool
}
extension IAddressValidationManagerBLL where Self: IValidationManagerBLL {
    public typealias T = IUserAddressDTODAL
    
    public typealias M = IAddressValidationDTOBLL
    public func validate(model: IUserAddressDTODAL) -> Bool {
        fatalError("Must override this function")
    }
    
}
