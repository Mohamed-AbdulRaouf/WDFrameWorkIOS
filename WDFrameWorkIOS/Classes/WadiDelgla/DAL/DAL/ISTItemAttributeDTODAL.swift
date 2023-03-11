//
//  ISTItemAttributeDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/20/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
public protocol ISTItemAttributeDTODAL :AnyObject {
    var itemId:  Int { get set }
    var sizeId: Int { get set }
    var choiceId: Int { get set }
    var itemChoicePrice: Float { get set }
    var amount: Int { get set }
    var itemChoiceName : String {get set}
    var itemCurrencyCode : String {get set}
}
