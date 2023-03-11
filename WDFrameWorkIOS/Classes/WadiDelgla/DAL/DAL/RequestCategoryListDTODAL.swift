//
//  RequestCategoryListDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/13/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import SwiftyJSON
public class RequestCategoryListDTODAL : IRequestCategoryListDTODAL{
    public var brandId: Observable<Int?> = Observable<Int?>(nil)
    
    public var pageIndex: Observable<Int?> = Observable<Int?>(nil)
    
    public var pageSize: Observable<Int?> = Observable<Int?>(nil)
 
    public var areaId: Observable<Int?> = Observable<Int?>(nil)
    public init(){}
}
