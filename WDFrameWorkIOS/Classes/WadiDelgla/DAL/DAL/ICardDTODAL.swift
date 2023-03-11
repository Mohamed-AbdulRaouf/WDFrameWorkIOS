//
//  ICardDTO.swift
//  DAL
//
//  Created by SimpleTouch on 8/6/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol  ICardDTODAL:AnyObject {
    var cardHolderName: Observable<String?> { get set }
    var cardNumber: Observable<String?> { get set }
    var cardExpiryDate: Observable<String?> { get set }
    var cardCvv: Observable<String?> {get set}
}
