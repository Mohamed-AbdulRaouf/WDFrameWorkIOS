//
//  ISTKashierTokenDTO.swift
//  DAL
//
//  Created by SimpleTouch on 8/11/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//


import Foundation
public protocol ISTKashierTokenDTODAL :AnyObject {
    var cardNumber:  String { get set }
    var token: String { get set }
    var cardExpiryMonth: String { get set }
    var cardExpiryYear: String { get set }
}
