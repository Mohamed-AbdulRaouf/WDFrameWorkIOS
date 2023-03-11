//
//  ICalOrderResponseDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/21/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol  ICalOrderResponseDTODAL:AnyObject {
    var orderId: Observable<Int?> { get set }
    var pointEquivalent: Observable<Int?> {get set}
    var isCurrentRewardIdValid: Observable<Bool?> {get set}
    var mobile: Observable<String?> {get set}
    var currencyCode: Observable<String?> {get set}
    var redeemPoint: Observable<Int?> {get set}
    var totalPay: Observable<Float?> {get set}
    var deliveryCharges: Observable<Float?> {get set}
    var discount: Observable<Float?> {get set}
    var taxAmount:Observable<Float?> {get set}
    var subTotal: Observable<Float?> {get set}
    var isMinOrderValueForCouponDicountValid: Observable<Bool?> {get set}
    var minOrderValueForCouponDicount: Observable<Int?> {get set}
    var couponDicount: Observable<Float?> {get set}
    var loyaltyDiscount: Observable<Float?> {get set}
    var actualSubTotal: Observable<Float?> {get set}
    var itemsCount: Observable<Int?> {get set}
    var currentCustomerIsRegistered: Observable<Bool?> {get set}
    var currentCustomerPointsInBrand: Observable<Int?> {get set}
    var equivalentPointsAmount: Observable<Float?> {get set}
    var minRedeemAmount: Observable<Float?> {get set}
    var maxRedeemAmount: Observable<Float?> {get set}
    var isOrderingOnlineAvailable: Observable<Bool?> {get set}
    var orderComment: Observable<String?> {get set}
}
