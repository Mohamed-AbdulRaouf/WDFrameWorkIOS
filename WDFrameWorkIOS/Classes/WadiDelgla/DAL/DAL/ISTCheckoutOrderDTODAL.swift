//
//  ISTCheckoutOrderDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/20/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
public protocol ISTCheckoutOrderDTODAL :AnyObject {
    var brandId: Int {get set}
    var isOnlinePayment: Bool? {get set}
    var isBrandDeliveryAtStore: Bool? {get set}
    var brandImage: String {get set}
    var brandName: String {get set}
    var redeemPointsAmount: Int {get set}
    var referenceTransactionId: String {get set}
    var referenceInvoiceId: String {get set}

//    var allowCouponRedeem: Bool {get set}
//    var currencyCode: String {get set}
//    var deliveryFees: Double {get set}
//    var discountAmount: Double {get set}
//    var equivalentAmount: Double {get set}
//    var isDeliveryFeesPercent: Bool {get set}
//    var maxRedeemAmount: Float {get set}
//    var minOrderToDeliver: Float {get set}
//    var minRedeemAmount: Float {get set}
//    var myPoints: Int {get set}
    var couponCode: String {get set}
    var selectedAreaId: Int {get set}
    var isSelectDeliveryAtStore: Bool {get set}
//    var isUserLogin: Bool {get set}
//    var selectedAreaName: String {get set}
//    var isCustomerRegisterInBrand: Bool {get set}
//    var isCurrentRewardIdValid: Bool {get set}
    var selectedAddressId: Int {get set}
    var orderPaymentTypeId: Int {get set}
    var userAddressDetails: String {get set}
    var cartItems : [STCartItemDTODAL] {get set}
    var JSONRepresentation: Dictionary<String, Any> {get}
    var orderComment: String {get set}
//    var paymentData : STCartPaymentDTO? {get set}
    var frontOrderReferenceId: String? {get set}
    var phone2: String? {get set}
    var merchantRefNumber: String? {get set}
    var referenceNumber: String? {get set}
}
