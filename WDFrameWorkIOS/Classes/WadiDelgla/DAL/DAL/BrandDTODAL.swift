//
//  BrandDTO.swift
//  DAL
//
//  Created by Nermeen Mohamed on 11/4/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import SwiftyJSON
public  class BrandDTODAL : IBrandDTODAL,Codable{
    
    public var brandName: Observable<String?> = Observable<String?>(nil)
    
    public var brandLogoPath: Observable<String?> = Observable<String?>(nil)
    
    public var brandId: Observable<Int?> = Observable<Int?>(nil)
    
    public var currency: Observable<String?> = Observable<String?>(nil)
    
    public var isOnLinePayment: Observable<Bool?> = Observable<Bool?>(nil)
    
    public var isOnlineOrder: Observable<Bool?> = Observable<Bool?>(nil)
    
    public var minOrderValueToDeliver: Observable<Float?> = Observable<Float?>(nil)
    
    public var estimatedDeliveryTime: Observable<Int?> = Observable<Int?>(nil)
    
    public var is24Hour: Observable<Bool?> = Observable<Bool?>(nil)
    
    public var minRedeemAmount: Observable<Float?> = Observable<Float?>(nil)
    
    public var maxRedeemAmount: Observable<Float?> = Observable<Float?>(nil)
    
    public var openTime: Observable<String?> = Observable<String?>(nil)
    
    public var closeTime: Observable<String?> = Observable<String?>(nil)
    
    public var ratingValue: Observable<Float?> = Observable<Float?>(nil)
    
    public var allowRedeemWithCouponDiscount: Observable<Bool?> = Observable<Bool?>(nil)
    
    public var currentCustomerPointsInBrand: Observable<Int?> = Observable<Int?>(nil)
    
    public var registerPointsAmount: Observable<Int?> = Observable<Int?>(nil)
    
    public var currentCustomerIsRegistered: Observable<Bool?> = Observable<Bool?>(nil)
    
    public var isCurrentRewardIdValid: Observable<Bool?> = Observable<Bool?>(nil)
    
    public var totalRedeemValue: Observable<Int?> = Observable<Int?>(nil)
    
    public var totalReword: Observable<Int?> = Observable<Int?>(nil)
    
    public var reviewersNumber: Observable<Int?> = Observable<Int?>(nil)
    
    public var callCenterNumber: Observable<String?> = Observable<String?>(nil)
    
    public var isOpen: Observable<Bool?> = Observable<Bool?>(nil)
    
    public var deliveryFeesAmount: Observable<Float?> = Observable<Float?>(nil)
    
    public var isDeliveryFeesPercent: Observable<Bool?> = Observable<Bool?>(nil)
    
    public var equivalentPointsAmount: Observable<Float?> = Observable<Float?>(nil)
    
    public var shareCode: Observable<String?> = Observable<String?>(nil)
    
    public var shareUrl: Observable<String?> = Observable<String?>(nil)
    
    public var customerHistoryID: Observable<String?> = Observable<String?>(nil)
    
    public var isBrandHasRatingItems: Observable<Bool?> = Observable<Bool?>(nil)
    
    public var usingPointsConcept: Observable<Bool?> = Observable<Bool?>(nil)
    
    public var isOrderRatedBefore: Observable<Bool?> = Observable<Bool?>(nil)
    
    public var backgroundAdsImage: Observable<String?> = Observable<String?>(nil)
    
    public var numberOfUserRate: Observable<Int?> = Observable<Int?>(nil)
    
    public var equivalentRewardPointsAmount: Observable<Float?> = Observable<Float?>(nil)
    
    public var equivalentRedeemPointsAmount: Observable<Float?> = Observable<Float?>(nil)
    
    public var isCanShareToOthers: Observable<Bool?> = Observable<Bool?>(nil)
    
    public var facilities: Observable<[IFacilityDTODAL]?> = Observable<[IFacilityDTODAL]?>(nil)
    
    public var cuisines: Observable<[ICuisinesDTODAL]?> = Observable<[ICuisinesDTODAL]?>(nil)
    
    public var customerOrders: Observable<[IBaseOrderDTODAL]?> = Observable<[IBaseOrderDTODAL]?>(nil)
    
    public var isDefaultRewardValid: Observable<Bool?> = Observable<Bool?>(nil)
    
    public var showReferralInput: Observable<Bool?> = Observable<Bool?>(nil)
    
    public var contractTypeId: Observable<Int?> = Observable<Int?>(nil)
    
    public var deliveryAtStore: Observable<Bool?> = Observable<Bool?>(nil)
    
    public var usingLocationService: Observable<Bool?> = Observable<Bool?>(nil)

    public init(){}
    enum CodingKeys: String, CodingKey {
        case ID = "ID"
        case brandName = "Name"
        case brandLogo = "Logo"
        case currencyCode = "currencyCode"
        case OnLinePayment = "OnLinePayment"
        case isOnlineOrder = "OnLineOrder"
        case minOrderToDeliver = "MinOrderToDeliver"
        case estimatedDeliveryTime = "EstimatedDeliveryTime"
        case Is24Hour = "Is24Hour"
        case MinRedeemAmount = "MinRedeemAmount"
        case MaxRedeemAmount = "MaxRedeemAmount"
        case OpenTime = "OpenTime"
        case CloseTime = "CloseTime"
        case Rating = "Rating"
        case AllowRedeemWithCouponDiscount = "AllowRedeemWithCouponDiscount"
        case CurrentCustomerPointsInBrand = "CurrentCustomerPointsInBrand"
        case CurrentCustomerIsRegistered = "CurrentCustomerIsRegistered"
        case IsCurrentRewardIdValid = "IsCurrentRewardIdValid"
        case TotalRedeem = "TotalRedeem"
        case TotalReword = "TotalReword"
        case ReviewersNumber = "ReviewersNumber"
        case CallCenterNumber = "CallCenterNumber"
        case IsOpen = "IsOpen"
        case DeliveryFeesAmount = "DeliveryFeesAmount"
        case IsDeliveryFeesPercent = "IsDeliveryFeesPercent"
        case EquivalentPointsAmount = "EquivalentPointsAmount"
        case ShareCode = "ShareCode"
        case ShareUrl = "ShareUrl"
        case CustomerHistoryID = "CustomerHistoryID"
        case IsBrandHasRatingItems = "IsBrandHasRatingItems"
        case IsOrderRatedBefore = "IsOrderRatedBefore"
        case BackgroundAdsImage = "BackgroundAdsImage"
        case NumberOfUserRate = "NumberOfUserRate"
        case EquivalentRewardPointsAmount = "EquivalentRewardPointsAmount"
        case EquivalentRedeemPointsAmount = "EquivalentRedeemPointsAmount"
        case IsCanShareToOthers = "CanShareToOthers"
        case RegisterPointsAmount = "RegisterPointsAmount"
        case UsingPointsConcept = "UsingPointsConcept"
        case IsDefaultRewardValid = "IsDefaultRewardValid"
        case brandId = "BrandID"
        case showReferralInput = "ShowReferralInput"
        case contractTypeId = "ContractTypeId"
        case deliveryAtStore = "DeliveryAtStore"
        case facilities = "facilities"
        case cuisines = "cuisines"
        case customerOrders = "customerOrders"
        case usingLocationService = "UsingLocationService"
    }
    public init(jsonForBrandList: JSON){
        let brandJson = jsonForBrandList
        self.brandName.value = brandJson[CodingKeys.brandName.rawValue].stringValue
        self.brandLogoPath.value = brandJson["BrandLogoPath"].stringValue
        self.brandId.value = brandJson[CodingKeys.ID.rawValue].intValue
        self.currency.value = brandJson[CodingKeys.currencyCode.rawValue].stringValue
        self.isOnLinePayment.value = brandJson[CodingKeys.OnLinePayment.rawValue].boolValue
        self.isOnlineOrder.value = brandJson[CodingKeys.isOnlineOrder.rawValue].boolValue
        self.minOrderValueToDeliver.value = brandJson[CodingKeys.minOrderToDeliver.rawValue].floatValue
        self.estimatedDeliveryTime.value = brandJson[CodingKeys.estimatedDeliveryTime.rawValue].intValue
        self.is24Hour.value = brandJson[CodingKeys.Is24Hour.rawValue].boolValue
        self.minRedeemAmount.value =  brandJson[CodingKeys.MinRedeemAmount.rawValue].floatValue
        self.maxRedeemAmount.value = brandJson[CodingKeys.MaxRedeemAmount.rawValue].floatValue
        self.openTime.value = brandJson[CodingKeys.OpenTime.rawValue].stringValue
        self.closeTime.value = brandJson[CodingKeys.CloseTime.rawValue].stringValue
        self.ratingValue.value = brandJson[CodingKeys.Rating.rawValue].floatValue
        self.allowRedeemWithCouponDiscount.value = brandJson[CodingKeys.AllowRedeemWithCouponDiscount.rawValue].boolValue
        self.currentCustomerPointsInBrand.value = brandJson[CodingKeys.CurrentCustomerPointsInBrand.rawValue].intValue
        self.currentCustomerIsRegistered.value = brandJson[CodingKeys.CurrentCustomerIsRegistered.rawValue].boolValue
        self.isCurrentRewardIdValid.value = brandJson[CodingKeys.IsCurrentRewardIdValid.rawValue].boolValue
        self.totalRedeemValue.value = brandJson[CodingKeys.TotalRedeem.rawValue].intValue
        self.totalReword.value = brandJson[CodingKeys.TotalReword.rawValue].intValue
        self.reviewersNumber.value = brandJson[CodingKeys.ReviewersNumber.rawValue].intValue
        self.callCenterNumber.value = brandJson[CodingKeys.CallCenterNumber.rawValue].stringValue
        self.isOpen.value = brandJson[CodingKeys.IsOpen.rawValue].boolValue
        self.deliveryFeesAmount.value = brandJson[CodingKeys.DeliveryFeesAmount.rawValue].floatValue
        self.isDeliveryFeesPercent.value = brandJson[CodingKeys.IsDeliveryFeesPercent.rawValue].boolValue
        self.equivalentPointsAmount.value = brandJson[CodingKeys.EquivalentPointsAmount.rawValue].floatValue
        self.shareCode.value = brandJson[CodingKeys.ShareCode.rawValue].stringValue
        self.shareUrl.value = brandJson[CodingKeys.ShareUrl.rawValue].stringValue
        self.customerHistoryID.value = brandJson[CodingKeys.CustomerHistoryID.rawValue].stringValue
        self.isBrandHasRatingItems.value = brandJson[CodingKeys.IsBrandHasRatingItems.rawValue].boolValue
        self.isOrderRatedBefore.value = brandJson[CodingKeys.IsOrderRatedBefore.rawValue].boolValue
        self.backgroundAdsImage.value = brandJson[CodingKeys.BackgroundAdsImage.rawValue].stringValue
        self.numberOfUserRate.value = brandJson[CodingKeys.NumberOfUserRate.rawValue].intValue
        self.equivalentRewardPointsAmount.value = brandJson[CodingKeys.EquivalentRewardPointsAmount.rawValue].floatValue
        self.equivalentRedeemPointsAmount.value = brandJson[CodingKeys.EquivalentRedeemPointsAmount.rawValue].floatValue
        self.isCanShareToOthers.value = brandJson[CodingKeys.IsCanShareToOthers.rawValue].boolValue
        self.registerPointsAmount.value = brandJson[CodingKeys.RegisterPointsAmount.rawValue].intValue
        self.cuisines.value = brandJson["cuisines"].arrayValue.map({try! CuisinesDTODAL.init(json: $0)})
        self.facilities.value = brandJson["facilities"].arrayValue.map({try! FacilityDTODAL.init(json: $0)})
        self.customerOrders.value = brandJson["customerOrders"].arrayValue.map({try! BaseOrderDTODAL.init(json: $0)})
        self.usingPointsConcept.value = brandJson[CodingKeys.UsingPointsConcept.rawValue].boolValue
        self.isDefaultRewardValid.value = brandJson[CodingKeys.IsDefaultRewardValid.rawValue].boolValue
        self.showReferralInput.value = brandJson[CodingKeys.showReferralInput.rawValue].boolValue
        self.contractTypeId.value = brandJson[CodingKeys.contractTypeId.rawValue].intValue
        self.deliveryAtStore.value = brandJson[CodingKeys.deliveryAtStore.rawValue].boolValue
        self.usingLocationService.value = brandJson[CodingKeys.usingLocationService.rawValue].boolValue
    }
    public init(json: JSON)  {
        let brandJson = json["brandInfo"]
        self.brandName.value = brandJson[CodingKeys.brandName.rawValue].stringValue
        self.brandLogoPath.value = brandJson[CodingKeys.brandLogo.rawValue].stringValue
        if  brandJson[CodingKeys.ID.rawValue].intValue != 0 {
            self.brandId.value = brandJson[CodingKeys.ID.rawValue].intValue
        }
        if brandJson[CodingKeys.brandId.rawValue] != 0  {
            self.brandId.value = brandJson[CodingKeys.brandId.rawValue].intValue
        }
        self.currency.value = brandJson[CodingKeys.currencyCode.rawValue].stringValue
        self.isOnLinePayment.value = brandJson[CodingKeys.OnLinePayment.rawValue].boolValue
        self.isOnlineOrder.value = brandJson[CodingKeys.isOnlineOrder.rawValue].boolValue
        self.minOrderValueToDeliver.value = brandJson[CodingKeys.minOrderToDeliver.rawValue].floatValue
        self.estimatedDeliveryTime.value = brandJson[CodingKeys.estimatedDeliveryTime.rawValue].intValue
        self.is24Hour.value = brandJson[CodingKeys.Is24Hour.rawValue].boolValue
        self.minRedeemAmount.value =  brandJson[CodingKeys.MinRedeemAmount.rawValue].floatValue
        self.maxRedeemAmount.value = brandJson[CodingKeys.MaxRedeemAmount.rawValue].floatValue
        self.openTime.value = brandJson[CodingKeys.OpenTime.rawValue].stringValue
        self.closeTime.value = brandJson[CodingKeys.CloseTime.rawValue].stringValue
        self.ratingValue.value = brandJson[CodingKeys.Rating.rawValue].floatValue
        self.allowRedeemWithCouponDiscount.value = brandJson[CodingKeys.AllowRedeemWithCouponDiscount.rawValue].boolValue
        self.currentCustomerPointsInBrand.value = brandJson[CodingKeys.CurrentCustomerPointsInBrand.rawValue].intValue
        self.currentCustomerIsRegistered.value = brandJson[CodingKeys.CurrentCustomerIsRegistered.rawValue].boolValue
        self.isCurrentRewardIdValid.value = brandJson[CodingKeys.IsCurrentRewardIdValid.rawValue].boolValue
        self.totalRedeemValue.value = brandJson[CodingKeys.TotalRedeem.rawValue].intValue
        self.totalReword.value = brandJson[CodingKeys.TotalReword.rawValue].intValue
        self.reviewersNumber.value = brandJson[CodingKeys.ReviewersNumber.rawValue].intValue
        self.callCenterNumber.value = brandJson[CodingKeys.CallCenterNumber.rawValue].stringValue
        self.isOpen.value = brandJson[CodingKeys.IsOpen.rawValue].boolValue
        self.deliveryFeesAmount.value = brandJson[CodingKeys.DeliveryFeesAmount.rawValue].floatValue
        self.isDeliveryFeesPercent.value = brandJson[CodingKeys.IsDeliveryFeesPercent.rawValue].boolValue
        self.equivalentPointsAmount.value = brandJson[CodingKeys.EquivalentPointsAmount.rawValue].floatValue
        self.shareCode.value = brandJson[CodingKeys.ShareCode.rawValue].stringValue
        self.shareUrl.value = brandJson[CodingKeys.ShareUrl.rawValue].stringValue
        self.customerHistoryID.value = brandJson[CodingKeys.CustomerHistoryID.rawValue].stringValue
        self.isBrandHasRatingItems.value = brandJson[CodingKeys.IsBrandHasRatingItems.rawValue].boolValue
        self.isOrderRatedBefore.value = brandJson[CodingKeys.IsOrderRatedBefore.rawValue].boolValue
        self.backgroundAdsImage.value = brandJson[CodingKeys.BackgroundAdsImage.rawValue].stringValue
        self.numberOfUserRate.value = brandJson[CodingKeys.NumberOfUserRate.rawValue].intValue
        self.equivalentRewardPointsAmount.value = brandJson[CodingKeys.EquivalentRewardPointsAmount.rawValue].floatValue
        self.equivalentRedeemPointsAmount.value = brandJson[CodingKeys.EquivalentRedeemPointsAmount.rawValue].floatValue
        self.isCanShareToOthers.value = brandJson[CodingKeys.IsCanShareToOthers.rawValue].boolValue
        self.registerPointsAmount.value = brandJson[CodingKeys.RegisterPointsAmount.rawValue].intValue
        self.cuisines.value = brandJson["cuisines"].arrayValue.map({try! CuisinesDTODAL.init(json: $0)})
        self.facilities.value = brandJson["facilities"].arrayValue.map({try! FacilityDTODAL.init(json: $0)})
        self.customerOrders.value = brandJson["customerOrders"].arrayValue.map({try! BaseOrderDTODAL.init(json: $0)})
        self.usingPointsConcept.value = brandJson[CodingKeys.UsingPointsConcept.rawValue].boolValue
        self.isDefaultRewardValid.value = brandJson[CodingKeys.IsDefaultRewardValid.rawValue].boolValue
        
        self.showReferralInput.value = brandJson[CodingKeys.showReferralInput.rawValue].boolValue
        self.contractTypeId.value = brandJson[CodingKeys.contractTypeId.rawValue].intValue
        self.deliveryAtStore.value = brandJson[CodingKeys.deliveryAtStore.rawValue].boolValue
        self.usingLocationService.value = brandJson[CodingKeys.usingLocationService.rawValue].boolValue

    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(brandName.value, forKey: .brandName)
        try container.encode(brandLogoPath.value, forKey: .brandLogo)
        try container.encode(brandId.value, forKey: .brandId)
        try container.encode(currency.value, forKey: .currencyCode)
        try container.encode(isOnLinePayment.value, forKey: .OnLinePayment)
        try container.encode(isOnlineOrder.value, forKey: .isOnlineOrder)
        try container.encode(minOrderValueToDeliver.value, forKey: .minOrderToDeliver)
        try container.encode(estimatedDeliveryTime.value, forKey: .estimatedDeliveryTime)
        try container.encode(is24Hour.value, forKey: .Is24Hour)
        try container.encode(minRedeemAmount.value, forKey: .MinRedeemAmount)
        try container.encode(maxRedeemAmount.value, forKey: .MaxRedeemAmount)
        try container.encode(openTime.value, forKey: .OpenTime)
        try container.encode(closeTime.value, forKey: .CloseTime)
        try container.encode(ratingValue.value, forKey: .Rating)
        try container.encode(allowRedeemWithCouponDiscount.value, forKey: .AllowRedeemWithCouponDiscount)
        try container.encode(currentCustomerPointsInBrand.value, forKey: .CurrentCustomerPointsInBrand)
        try container.encode(registerPointsAmount.value, forKey: .RegisterPointsAmount)
        try container.encode(currentCustomerIsRegistered.value, forKey: .CurrentCustomerIsRegistered)
        try container.encode(isCurrentRewardIdValid.value, forKey: .IsCurrentRewardIdValid)
        try container.encode(totalRedeemValue.value, forKey: .TotalRedeem)
        try container.encode(totalReword.value, forKey: .TotalReword)
        try container.encode(reviewersNumber.value, forKey: .ReviewersNumber)
        try container.encode(callCenterNumber.value, forKey: .CallCenterNumber)
        try container.encode(isOpen.value, forKey: .IsOpen)
        try container.encode(deliveryFeesAmount.value, forKey: .DeliveryFeesAmount)
        try container.encode(isDeliveryFeesPercent.value, forKey: .IsDeliveryFeesPercent)
        try container.encode(equivalentPointsAmount.value, forKey: .EquivalentPointsAmount)
        try container.encode(shareCode.value, forKey: .ShareCode)
        try container.encode(shareUrl.value, forKey: .ShareUrl)
        try container.encode(customerHistoryID.value, forKey: .CustomerHistoryID)
        try container.encode(usingPointsConcept.value, forKey: .UsingPointsConcept)
        try container.encode(isOrderRatedBefore.value, forKey: .IsOrderRatedBefore)
        try container.encode(backgroundAdsImage.value, forKey: .BackgroundAdsImage)
        try container.encode(numberOfUserRate.value, forKey: .NumberOfUserRate)
        try container.encode(equivalentRewardPointsAmount.value, forKey: .EquivalentRewardPointsAmount)
        try container.encode(equivalentRedeemPointsAmount.value, forKey: .EquivalentRedeemPointsAmount)
        try container.encode(isCanShareToOthers.value, forKey: .IsCanShareToOthers)
        try container.encode(isDefaultRewardValid.value, forKey: .IsDefaultRewardValid)
        try container.encode(showReferralInput.value, forKey: .showReferralInput)
        try container.encode(contractTypeId.value, forKey: .contractTypeId)
        try container.encode(deliveryAtStore.value, forKey: .deliveryAtStore)
        try container.encode(usingLocationService.value, forKey: .usingLocationService)

//        try container.encode(customerOrders.value, forKey: .customerOrders)

        //           public var facilities: Observable<[IFacilityDTO]?> = Observable<[IFacilityDTO]?>(nil)
        //
        //           public var cuisines: Observable<[ICuisinesDTO]?> = Observable<[ICuisinesDTO]?>(nil)
        //
        //           public var customerOrders: Observable<[IBaseOrderDTO]?> = Observable<[IBaseOrderDTO]?>(nil)
    }
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.brandName.value =  try container.decodeIfPresent(String.self, forKey: .brandName)
        self.brandLogoPath.value =  try container.decodeIfPresent(String.self, forKey: .brandLogo)
        self.brandId.value =  try container.decodeIfPresent(Int.self, forKey: .brandId)
        self.currency.value =  try container.decodeIfPresent(String.self, forKey: .currencyCode)
        self.isOnLinePayment.value =  try container.decodeIfPresent(Bool.self, forKey: .OnLinePayment)
        self.isOnlineOrder.value =  try container.decodeIfPresent(Bool.self, forKey: .isOnlineOrder)
        self.minOrderValueToDeliver.value =  try container.decodeIfPresent(Float.self, forKey: .minOrderToDeliver)
        self.estimatedDeliveryTime.value =  try container.decodeIfPresent(Int.self, forKey: .estimatedDeliveryTime)
        self.is24Hour.value =  try container.decodeIfPresent(Bool.self, forKey: .Is24Hour)
        self.minRedeemAmount.value =  try container.decodeIfPresent(Float.self, forKey: .MinRedeemAmount)
        self.maxRedeemAmount.value =  try container.decodeIfPresent(Float.self, forKey: .MaxRedeemAmount)
        self.openTime.value =  try container.decodeIfPresent(String.self, forKey: .OpenTime)
        self.closeTime.value =  try container.decodeIfPresent(String.self, forKey: .CloseTime)
        self.ratingValue.value =  try container.decodeIfPresent(Float.self, forKey: .Rating)
        self.allowRedeemWithCouponDiscount.value =  try container.decodeIfPresent(Bool.self, forKey: .AllowRedeemWithCouponDiscount)
        self.currentCustomerPointsInBrand.value =  try container.decodeIfPresent(Int.self, forKey: .CurrentCustomerPointsInBrand)
        self.registerPointsAmount.value =  try container.decodeIfPresent(Int.self, forKey: .RegisterPointsAmount)
        self.currentCustomerIsRegistered.value =  try container.decodeIfPresent(Bool.self, forKey: .CurrentCustomerIsRegistered)
        self.isCurrentRewardIdValid.value =  try container.decodeIfPresent(Bool.self, forKey: .IsCurrentRewardIdValid)
        self.totalRedeemValue.value =  try container.decodeIfPresent(Int.self, forKey: .TotalRedeem)
        self.totalReword.value =  try container.decodeIfPresent(Int.self, forKey: .TotalReword)
        self.reviewersNumber.value =  try container.decodeIfPresent(Int.self, forKey: .ReviewersNumber)
        self.callCenterNumber.value =  try container.decodeIfPresent(String.self, forKey: .CallCenterNumber)
        self.isOpen.value =  try container.decodeIfPresent(Bool.self, forKey: .IsOpen)
        self.deliveryFeesAmount.value =  try container.decodeIfPresent(Float.self, forKey: .DeliveryFeesAmount)
        self.isDeliveryFeesPercent.value =  try container.decodeIfPresent(Bool.self, forKey: .IsDeliveryFeesPercent)
        self.equivalentPointsAmount.value =  try container.decodeIfPresent(Float.self, forKey: .EquivalentPointsAmount)
        self.shareCode.value =  try container.decodeIfPresent(String.self, forKey: .ShareCode)
        self.shareUrl.value =  try container.decodeIfPresent(String.self, forKey: .ShareUrl)
        self.customerHistoryID.value =  try container.decodeIfPresent(String.self, forKey: .CustomerHistoryID)
        self.usingPointsConcept.value =  try container.decodeIfPresent(Bool.self, forKey: .UsingPointsConcept)
        self.isOrderRatedBefore.value =  try container.decodeIfPresent(Bool.self, forKey: .IsOrderRatedBefore)
        self.backgroundAdsImage.value =  try container.decodeIfPresent(String.self, forKey: .BackgroundAdsImage)
        self.numberOfUserRate.value =  try container.decodeIfPresent(Int.self, forKey: .NumberOfUserRate)
        self.equivalentRewardPointsAmount.value =  try container.decodeIfPresent(Float.self, forKey: .EquivalentRewardPointsAmount)
        self.equivalentRedeemPointsAmount.value =  try container.decodeIfPresent(Float.self, forKey: .EquivalentRedeemPointsAmount)
        self.isCanShareToOthers.value =  try container.decodeIfPresent(Bool.self, forKey: .IsCanShareToOthers)
        self.isDefaultRewardValid.value =  try container.decodeIfPresent(Bool.self, forKey: .IsDefaultRewardValid)
        self.showReferralInput.value =  try container.decodeIfPresent(Bool.self, forKey: .showReferralInput)
        self.contractTypeId.value =  try container.decodeIfPresent(Int.self, forKey: .contractTypeId)
        self.deliveryAtStore.value =  try container.decodeIfPresent(Bool.self, forKey: .deliveryAtStore)
        self.usingLocationService.value =  try container.decodeIfPresent(Bool.self, forKey: .usingLocationService)

    }
    
}
