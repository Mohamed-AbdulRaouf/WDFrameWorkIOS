//
//  BaseOrderDTO.swift
//  DAL
//
//  Created by Nermeen Mohamed on 11/4/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import SwiftyJSON
public class BaseOrderDTODAL : IBaseOrderDTODAL,Codable{
    public var orderNumber: Observable<String?> = Observable<String?>(nil)
    
    public var orderAmount: Observable<Float?> = Observable<Float?>(nil)
    
    public var rewardPoints: Observable<Int?> = Observable<Int?>(nil)
    
    public var redeemedPoints: Observable<Int?> = Observable<Int?>(nil)
    
    public var rating: Observable<Float?> = Observable<Float?>(nil)
    
    public var ratingComment: Observable<String?> = Observable<String?>(nil)
    
    public var orderDate: Observable<String?> = Observable<String?>(nil)
    
    
    
    public init(){
    }
    
    enum CodingKeys: String, CodingKey {
        case OrderNumber = "OrderNumber"
        case OrderAmount = "OrderAmount"
        case RewardPoints = "RewardPoints"
        case RedeemedPoints = "RedeemedPoints"
        case Rating = "Rating"
        case RatingComment = "RatingComment"
        case OrderDate = "OrderDate"
    }
    public  init(json: JSON)  {
        
        self.orderNumber.value = json[CodingKeys.OrderNumber.rawValue].stringValue
        self.orderAmount.value = json[CodingKeys.OrderAmount.rawValue].floatValue
        self.rewardPoints.value = json[CodingKeys.RewardPoints.rawValue].intValue
        self.redeemedPoints.value = json[CodingKeys.RedeemedPoints.rawValue].intValue
        self.rating.value = json[CodingKeys.Rating.rawValue].floatValue
        self.ratingComment.value = json[CodingKeys.RatingComment.rawValue].stringValue
        self.orderDate.value = json[CodingKeys.OrderDate.rawValue].stringValue
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(orderNumber.value, forKey: .OrderNumber)
        try container.encode(orderAmount.value, forKey: .OrderAmount)
        try container.encode(rewardPoints.value, forKey: .RewardPoints)
        try container.encode(redeemedPoints.value, forKey: .RedeemedPoints)
        try container.encode(rating.value, forKey: .Rating)
        try container.encode(ratingComment.value, forKey: .RatingComment)
        try container.encode(orderDate.value, forKey: .OrderDate)
    }
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.orderNumber.value =  try container.decodeIfPresent(String.self, forKey: .OrderNumber)
        self.orderAmount.value =  try container.decodeIfPresent(Float.self, forKey: .OrderAmount)
        self.rewardPoints.value =  try container.decodeIfPresent(Int.self, forKey: .RewardPoints)
        self.redeemedPoints.value =  try container.decodeIfPresent(Int.self, forKey: .RedeemedPoints)
        self.rating.value =  try container.decodeIfPresent(Float.self, forKey: .Rating)
        self.ratingComment.value =  try container.decodeIfPresent(String.self, forKey: .RatingComment)
        self.orderDate.value =  try container.decodeIfPresent(String.self, forKey: .OrderDate)
        
    }
}
