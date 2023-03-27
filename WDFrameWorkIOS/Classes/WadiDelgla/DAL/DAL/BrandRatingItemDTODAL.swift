//
//  BrandRatingItemDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/27/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//
import Foundation
import Bond
//import SwiftyJSON
public class BrandRatingItemDTODAL : IBrandRatingItemDTODAL{
    public var brandRatingItemId: Observable<Int?> = Observable<Int?>(nil)
    
    public var brandRatingItemName: Observable<String?> = Observable<String?>(nil)
    
    public var value: Observable<Float?> = Observable<Float?>(nil)
    
    public init(){}
    
    enum CodingKeys: String, CodingKey {
        case BrandRatingItemId = "BrandRatingItemId"
        case BrandRatingItemName = "BrandRatingItemName"
        case Value = "Value"
    }
    
    public init(json:JSON)   {
        self.brandRatingItemId.value = json[CodingKeys.BrandRatingItemId.rawValue].intValue
        self.brandRatingItemName.value = json[CodingKeys.BrandRatingItemName.rawValue].stringValue
        self.value.value = json[CodingKeys.Value.rawValue].floatValue
    }
    
    public  var JSONRepresentation: Dictionary<String, Any>  {
        var jsonedDict = [String:Any]()
        //        jsonedDict = super.JSONRepresentation
        jsonedDict[CodingKeys.BrandRatingItemId.rawValue] = brandRatingItemId.value ?? 0
        jsonedDict[CodingKeys.BrandRatingItemName.rawValue] = brandRatingItemName.value ?? ""
        jsonedDict[CodingKeys.Value.rawValue] = value.value ?? 0.0
        return jsonedDict
    }
}
