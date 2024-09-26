//
//  PaymentService.swift
//  BLL
//
//  Created by SimpleTouch on 8/6/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
////import DAL
//MARK:- PaymentService
 
public protocol PaymentServiceBLL :AnyObject {
    
    func validateCardData(cardData: ICardDTODAL,completion: @escaping onSuccessBLL)    
}

