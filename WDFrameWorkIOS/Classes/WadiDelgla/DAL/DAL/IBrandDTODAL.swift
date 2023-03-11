//
//  IBrandDTO.swift
//  DAL
//
//  Created by Nermeen Mohamed on 11/4/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol IBrandDTODAL :AnyObject {
    var brandName: Observable<String?> { get set }
    var brandLogoPath: Observable<String?> { get set }
    var brandId: Observable<Int?> { get set }
    var currency: Observable<String?> { get set }
    var isOnLinePayment: Observable<Bool?> { get set }
    var isOnlineOrder: Observable<Bool?> { get set }
    var minOrderValueToDeliver: Observable<Float?> { get set }
    var estimatedDeliveryTime: Observable<Int?> { get set }
    var is24Hour: Observable<Bool?> { get set }
    var minRedeemAmount: Observable<Float?> { get set }
    var maxRedeemAmount: Observable<Float?> { get set }
    var openTime:  Observable<String?> { get set }
    var closeTime:  Observable<String?> { get set }
    var ratingValue: Observable<Float?> { get set }
    var allowRedeemWithCouponDiscount: Observable<Bool?> { get set }
    var currentCustomerPointsInBrand: Observable<Int?> { get set }
    var registerPointsAmount: Observable<Int?> { get set }
    var currentCustomerIsRegistered: Observable<Bool?> { get set }
    var isCurrentRewardIdValid: Observable<Bool?> { get set }
    var totalRedeemValue: Observable<Int?> { get set }
    var totalReword: Observable<Int?> { get set }
    var reviewersNumber: Observable<Int?> { get set }
    var callCenterNumber: Observable<String?> { get set }
    var isOpen: Observable<Bool?> { get set }
    var deliveryFeesAmount: Observable<Float?> { get set }
    var isDeliveryFeesPercent: Observable<Bool?> { get set }
    var equivalentPointsAmount: Observable<Float?> { get set }
    var shareCode: Observable<String?> { get set }
    var shareUrl: Observable<String?> { get set }
    var customerHistoryID: Observable<String?> { get set }
    var isBrandHasRatingItems: Observable<Bool?> { get set }
    var isOrderRatedBefore: Observable<Bool?> { get set }
    var backgroundAdsImage: Observable<String?> { get set }
    var numberOfUserRate: Observable<Int?> { get set }
    var equivalentRewardPointsAmount: Observable<Float?> { get set }
    var equivalentRedeemPointsAmount: Observable<Float?> { get set }
    var isCanShareToOthers: Observable<Bool?> { get set }
    var facilities: Observable<[IFacilityDTODAL]?> { get set }
    var cuisines: Observable<[ICuisinesDTODAL]?> { get set }
    var customerOrders: Observable<[IBaseOrderDTODAL]?> { get set }
    var usingPointsConcept: Observable<Bool?> { get set }
    var isDefaultRewardValid: Observable<Bool?> { get set }
    var showReferralInput: Observable<Bool?> { get set }
    var contractTypeId: Observable<Int?> { get set }
    var deliveryAtStore: Observable<Bool?> { get set }
    var usingLocationService: Observable<Bool?> { get set }
    
}


