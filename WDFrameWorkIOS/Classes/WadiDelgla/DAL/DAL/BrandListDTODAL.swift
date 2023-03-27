//
//  BrandListDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/7/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
//import SwiftyJSON
public class BrandListDTODAL :IBrandListDTODAL{
    public var totalCount: Observable<Int?> = Observable<Int?>(nil)
    
    public var items: Observable<[BrandDTODAL]?> = Observable<[BrandDTODAL]?>(nil)
    
    public init(){}
    enum CodingKeys: String, CodingKey {
        case items = "Items"
        case totalCount = "TotalCount"
    }
    public init(forBrandListjson: JSON){
        self.totalCount.value = forBrandListjson["TotalCount"].intValue
        self.items.value = forBrandListjson["Items"].arrayValue.map({try! BrandDTODAL.init(jsonForBrandList: $0)})
    }
    public init(json:JSON)   {
        self.totalCount.value = json["TotalCount"].intValue
        self.items.value = json["Items"].arrayValue.map({try! BrandDTODAL.init(json: $0)})
    }
    
    
}
