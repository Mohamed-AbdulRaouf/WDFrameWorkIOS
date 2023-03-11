//
//  IOrderItemDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/14/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol  IOrderItemDTODAL:AnyObject {
    var currencyCode: Observable<String?> { get set }
    var orderDetailID: Observable<Int?> {get set}
    var itemId: Observable<Int?> {get set}
    var itemTitle: Observable<String?> { get set }
    var itemQty: Observable<Int?> {get set}
    var itemPrice: Observable<Float?> { get set }
    var itemImage : Observable<String?> { get set }
    var imagePath : Observable<String?> { get set }
    var itemTotal: Observable<Float?> { get set }
    var sizeName: Observable<String?> { get set }
    var couponTotalDiscount: Observable<Float?> { get set }
    var couponDiscountApply: Observable<Float?> { get set }
    var specialTax: Observable<Float?> { get set }
    var isItemHasChoices: Observable<Bool?> { get set }
    var itemChoices: Observable<[IOrderItemChoiceDTODAL]?> { get set}

}
