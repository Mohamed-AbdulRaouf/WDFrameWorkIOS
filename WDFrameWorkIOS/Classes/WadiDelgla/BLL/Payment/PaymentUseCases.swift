//
//  PaymentUseCases.swift
//  BLL
//
//  Created by SimpleTouch on 8/6/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation

////import DAL

public class PaymentUseCasesBLL : PaymentServiceBLL  {
    
    public init(){}
    public func validateCardData(cardData: ICardDTODAL,completion: @escaping onSuccessBLL) {
        //validate data
        let validationDTO = CreditCardValidationDTOBLL()
        let validation = CreditCardValidationManagerBLL(errorModel: validationDTO)
        
        guard validation.validate(model: cardData) else {
            completion(STResponseBLL(data: nil,error: STErrorBLL(validateError: validationDTO, APIError: nil)))
            return
        }
        completion(STResponseBLL(data: true, error: nil))
    }
}
