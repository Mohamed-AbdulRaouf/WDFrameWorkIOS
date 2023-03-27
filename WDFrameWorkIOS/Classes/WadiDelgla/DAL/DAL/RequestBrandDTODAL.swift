//
//  RequestBrandDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/6/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
//import SwiftyJSON
public class RequestBrandDTODAL : IRequestBrandDTODAL{
    public var brandsMe: Observable<Int?> = Observable<Int?>(nil)
    
    public var areaID: Observable<Int?> = Observable<Int?>(nil)
    
    public var feedMe: Observable<String?> = Observable<String?>(nil)
    
    public var cusineIDs: Observable<String?> = Observable<String?>(nil)
    
    public var serviceIDs: Observable<String?> = Observable<String?>(nil)
    
    public var facilityIDs: Observable<String?> = Observable<String?>(nil)
    
    public var sortID: Observable<String?> = Observable<String?>(nil)
    
    public var lang: Observable<String?> = Observable<String?>(nil)
    
    public var pageIndex: Observable<String?> = Observable<String?>(nil)
    
    public var pageSize: Observable<String?> = Observable<String?>(nil)
    
    public var brandName: Observable<String?> = Observable<String?>(nil)
    
     public init(){}
}
