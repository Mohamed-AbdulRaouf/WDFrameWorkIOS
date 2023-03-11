//
//  ISTCartPaymentDTO.swift
//  DAL
//
//  Created by SimpleTouch on 8/11/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
public protocol ISTCartPaymentDTODAL :AnyObject {
    var cardToken: STKashierTokenDTODAL? { get set }
    var cardData: CardDTODAL? { get set }
   
}
