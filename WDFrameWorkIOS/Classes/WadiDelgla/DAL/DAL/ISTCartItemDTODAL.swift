//
//  ISTCartItemDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/20/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
public protocol ISTCartItemDTODAL :AnyObject {
    var itemId:  Int { get set }
    var itemName: String {get set}
    var sizeId: Int { get set }
    var sizeName: String {get set}
    var amount: Int { get set }
    var priceWithChoices: Double {get set}
    var itemPrice: Double {get set}
    var subTotal: Double {get set}
    var itemImage: String {get set}
    var itemSizeId: Int { get set }
    var itemSizeChoiceDetailsId: Int { get set }
    var itemComment: String { get set }
    var visualCode: String { get set }
    var itemCurrencyCode: String { get set }
    var choices : [STItemAttributeDTODAL] {get set}
    func increament()
    func decreament()
    func updateItemComment(_ comment:String)
    
}
