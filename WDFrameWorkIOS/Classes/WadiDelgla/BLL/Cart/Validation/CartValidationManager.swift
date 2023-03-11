//
//  CartValidationManager.swift
//  BLL
//
//  Created by SimpleTouch on 11/17/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
////import DAL

public class CartValidationManagerBLL : IValidationManagerBLL{
    
    
    public var errorViewModel: ICartValidationDTOBLL?
    
    required public init(errorModel: ICartValidationDTOBLL){
        self.errorViewModel = errorModel
    }
    
    
    /// This Function validates item that user wants to be added to cart
    ///
    /// - Parameter model: model to be added to cart
    /// - Returns: it returns if model validate to be added or not valid
    public  func validate(model: IMenuItemsDTODAL) -> Bool {
        var valid = true
        
        if !validateSize(model.sizes.value ?? []){
            return false
        }
        if !validateChoiceGroupsMinMax((model.sizes.value?.first(where: {$0.isSelected.value ?? false}))!){
             valid = false
        }
//        if !validateChoiceGroupsMinMax(model){
//            valid = false
//        }
        return valid
    }
    
}
//
extension CartValidationManagerBLL : ICartValidationManagerBLL {
    /// validate if user select size of selected item
    ///
    /// - Parameter sizes: selected size for choosen item
    /// - Returns: ir return true if user select size
    public func validateSize(_ sizes: [IMenuSizeDTODAL]) -> Bool {
        guard let selectedSize =  sizes.first(where: {$0.isSelected.value ?? false}) else {
            errorViewModel?.msgError.value = R.string.localizable.select_size()
            return false
        }
        return true
    }
    
    //MARK: validate min max for each choice group
     /// This Function validates if user selected valid number of choices for selected item
     ///
     /// - Parameter selectedSize: selected size for choosen item
     /// - Returns: it retuns true if number of selected choices match min , max choices else return false
     public func validateChoiceGroupsMinMax(_ selectedSize: IMenuSizeDTODAL) -> Bool {
        
        guard  let choiceGroups = selectedSize.choiceGroups.value, choiceGroups.count > 0 else {
            errorViewModel?.msgError.value = ""
            return true
        }
        
        for item in choiceGroups {
            if item.minChoiceSelected.value != 0{
                if !(item.isSelectedMinMax.value ?? false){
                    errorViewModel?.msgError.value = RBLL.string.localizable.select_choice_msg("\(item.choiceGroupTitle.value ?? "")", "\(item.minChoiceSelected.value ?? 0)", "\(item.maxChoiceSelected.value ?? 0)")
                    return false
                }
            }
        }
        errorViewModel?.msgError.value = ""
        return true
    }
    
}
