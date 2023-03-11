//
//  AddressValidationManager.swift
//  BLL
//
//  Created by Nermeen Mohamed on 11/3/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Foundation
////import DAL

public class AddressValidationManagerBLL : IValidationManagerBLL{
    
    
    public var errorViewModel: IAddressValidationDTOBLL?
    
    required public init(errorModel: IAddressValidationDTOBLL){
        self.errorViewModel = errorModel
    }
    
    
    public  func validate(model: IUserAddressDTODAL) -> Bool {
        var valid = true
        
        if !validateBuildingNo(string: String(model.buildingNo.value ?? "")){
            valid = false
        }
        if !validateStreetName(string: model.streetName.value ?? ""){
            valid = false
        }
        if !validateFloorNo(string: String(model.floorNo.value ?? "")){
            valid = false
        }
        if !validateArea(string:String(model.areaId.value ?? 0)){
            valid = false
        }
        
        return valid
    }
    
}
// Fields to be validated
extension AddressValidationManagerBLL : IAddressValidationManagerBLL {
   
    //MARK: validate Building No
    public func validateBuildingNo(string: String) -> Bool {
        if string == "" {
        
            errorViewModel?.msgBuildingNoError.value =  ValidationErrorBLL.ErrorMessages.msgEmptyBuildingNo()
            return false
        }
        if string.withoutSpacesAndNewLines == "" {
            errorViewModel?.msgBuildingNoError.value  =  ValidationErrorBLL.ErrorMessages.msgInvalidBuildingNo()
            return false
        }
        errorViewModel?.msgBuildingNoError.value = ""
        return true
    }
    public func validateStreetName(string: String) -> Bool {
        if string == "" {
            errorViewModel?.msgStreetNameError.value =  ValidationErrorBLL.ErrorMessages.msgEmptyStreetName()
            return false
        }
        if string.withoutSpacesAndNewLines == "" {
            errorViewModel?.msgStreetNameError.value  =  ValidationErrorBLL.ErrorMessages.msgInvalidStreetName()
            return false
        }
        errorViewModel?.msgStreetNameError.value = ""
        return true
    }
    public func validateFloorNo(string: String) -> Bool {
        if string == "" {
            errorViewModel?.msgFloorNoError.value =  ValidationErrorBLL.ErrorMessages.msgEmptyFloorNo()
            return false
        }
        if string.withoutSpacesAndNewLines == "" {
            errorViewModel?.msgFloorNoError.value  =  ValidationErrorBLL.ErrorMessages.msgInvalidFloorNo()
            return false
        }
        errorViewModel?.msgFloorNoError.value = ""
        return true
    }
    public func validateArea(string: String) -> Bool {
        if string == "" {
            errorViewModel?.msgAreaError.value =  ValidationErrorBLL.ErrorMessages.msgEmptyFloorNo()
            return false
        }
        if string.withoutSpacesAndNewLines == "" {
            errorViewModel?.msgAreaError.value  =  ValidationErrorBLL.ErrorMessages.msgInvalidFloorNo()
            return false
        }
        errorViewModel?.msgAreaError.value = ""
        return true
    }
   
}
