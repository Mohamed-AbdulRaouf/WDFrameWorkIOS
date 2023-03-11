//
//  IOrderDetailsDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/14/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol  IOrderDetailsDTODAL:AnyObject {
    var brandName: Observable<String?> { get set }
    var brandLogo: Observable<String?> {get set}
    var currencyCode: Observable<String?> {get set}
    var orderTotal: Observable<Float?> {get set}
    var subTotal: Observable<Float?> {get set}
    var totalDiscount: Observable<Float?> {get set}
    var loyaltyDiscount: Observable<Float?> {get set}
    var couponDiscount: Observable<Float?> {get set}
    var deliveryFees: Observable<Float?> {get set}
    var totalTax: Observable<Float?> {get set}
    var isRewardProgramIdValid: Observable<Bool?> {get set}
}
