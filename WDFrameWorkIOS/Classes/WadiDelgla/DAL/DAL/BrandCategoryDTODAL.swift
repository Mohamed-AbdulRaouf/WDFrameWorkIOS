//
//  BrandCategoryDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/27/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
//import SwiftyJSON
public class BrandCategoryDTODAL : IBrandCategoryDTODAL{
    public var brandRateCategoryId: Observable<Int?> = Observable<Int?>(nil)
    
    public var brandRateCategoryName: Observable<String?> = Observable<String?>(nil)
    
    public var brandRatingItems: Observable<[BrandRatingItemDTODAL]?> = Observable<[BrandRatingItemDTODAL]?>(nil)
    
    public init(){}
    
    enum CodingKeys: String, CodingKey {
        case BrandRateCategoryId = "BrandRateCategoryId"
        case BrandRateCategoryName = "BrandRateCategoryName"
        case BrandRatingItems = "BrandRatingItems"
    }
    
    public init(json:JSON)   {
        self.brandRateCategoryId.value = json[CodingKeys.BrandRateCategoryId.rawValue].intValue
        self.brandRateCategoryName.value = json[CodingKeys.BrandRateCategoryName.rawValue].stringValue
        self.brandRatingItems.value = json[CodingKeys.BrandRatingItems.rawValue].arrayValue.map({try! BrandRatingItemDTODAL.init(json: $0)})
    }
    
    public  var JSONRepresentation: Dictionary<String, Any>  {
        var jsonedDict = [String:Any]()
        jsonedDict[CodingKeys.BrandRateCategoryId.rawValue] = brandRateCategoryId.value ?? 0
        jsonedDict[CodingKeys.BrandRateCategoryName.rawValue] = brandRateCategoryName.value ?? ""
        if let items = self.brandRatingItems.value , items.count > 0{
            jsonedDict[CodingKeys.BrandRatingItems.rawValue] = brandRatingItems.value?.map({$0.JSONRepresentation})
        }
         return jsonedDict
    }
    
   
}
