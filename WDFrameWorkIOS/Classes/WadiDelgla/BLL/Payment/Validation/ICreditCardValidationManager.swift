//
//  ICreditCardValidationManager.swift
//  BLL
//
//  Created by SimpleTouch on 8/6/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
////import DAL
public protocol ICreditCardValidationManagerBLL  {
    var errorViewModel: ICreditCardValidationDTOBLL? { get set }
    func validateCardHolderName(string: String) -> Bool
    func validateCardNumber(string: String) -> Bool
    func validateCardExpiryDate(string: String) -> Bool
    func validateCardCvv(string: String) -> Bool
}
extension ICreditCardValidationManagerBLL where Self: IValidationManagerBLL {
    public typealias T = ICardDTODAL
    
    public typealias M = ICreditCardValidationDTOBLL
    public func validate(model: ICardDTODAL) -> Bool {
        fatalError("Must override this function")
    }
    
}
