//
//  RateOrderDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/27/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
//import SwiftyJSON
public class RateOrderDTODAL : IRateOrderDTODAL{
    public var brandId: Observable<Int?> = Observable<Int?>(nil)
    
    public var brandName: Observable<String?> = Observable<String?>(nil)
    
    public var customerId: Observable<Int?> = Observable<Int?>(nil)
    
    public var customerHistoryId: Observable<Int?> = Observable<Int?>(nil)
    
    public var isOrderRatedBefore: Observable<Bool?> = Observable<Bool?>(nil)
    
    public var isBrandHasRatingItems: Observable<Bool?> = Observable<Bool?>(nil)
    
    public var brandCategories: Observable<[BrandCategoryDTODAL]?> = Observable<[BrandCategoryDTODAL]?>(nil)
    
    public var comment: Observable<String?> = Observable<String?>(nil)
    
    public init(){}
    
    enum CodingKeys: String, CodingKey {
        case BrandID = "BrandID"
        case BrandName = "BrandName"
        case CustomerID = "CustomerID"
        case CustomerHistoryID = "CustomerHistoryID"
        case IsOrderRatedBefore = "IsOrderRatedBefore"
        case IsBrandHasRatingItems = "IsBrandHasRatingItems"
        case BrandCategories = "BrandCategories"
        case Comment = "Comment"
    }
  
    public init(json:JSON)   {
        self.brandId.value = json[CodingKeys.BrandID.rawValue].intValue
        self.brandName.value = json[CodingKeys.BrandName.rawValue].stringValue
        self.customerId.value = json[CodingKeys.CustomerID.rawValue].intValue
        self.customerHistoryId.value = json[CodingKeys.CustomerHistoryID.rawValue].intValue
        self.isOrderRatedBefore.value = json[CodingKeys.IsOrderRatedBefore.rawValue].boolValue
        self.isBrandHasRatingItems.value = json[CodingKeys.IsBrandHasRatingItems.rawValue].boolValue
        self.comment.value = json[CodingKeys.Comment.rawValue].stringValue
        self.brandCategories.value = json[CodingKeys.BrandCategories.rawValue].arrayValue.map({try! BrandCategoryDTODAL.init(json: $0)})
    }
    
    public  var JSONRepresentation: Dictionary<String, Any>  {
        var jsonedDict = [String:Any]()
        jsonedDict[CodingKeys.BrandID.rawValue] = brandId.value ?? 0
        jsonedDict[CodingKeys.BrandName.rawValue] = brandName.value ?? 0
        jsonedDict[CodingKeys.CustomerID.rawValue] = customerId.value ?? 0
        jsonedDict[CodingKeys.CustomerHistoryID.rawValue] = customerHistoryId.value ?? 0
        jsonedDict[CodingKeys.IsOrderRatedBefore.rawValue] = isOrderRatedBefore.value ?? false
        
        jsonedDict[CodingKeys.IsBrandHasRatingItems.rawValue] = isBrandHasRatingItems.value ?? false
        jsonedDict[CodingKeys.Comment.rawValue] = comment.value ?? 0
        if let categories = self.brandCategories.value , categories.count > 0{
            jsonedDict[CodingKeys.BrandCategories.rawValue] = brandCategories.value?.map({$0.JSONRepresentation})
        }
        return jsonedDict
    }
}
