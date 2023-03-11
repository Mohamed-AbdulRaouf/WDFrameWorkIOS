//
//  IRequestCategoryListDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/13/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Foundation
import Bond
public protocol IRequestCategoryListDTODAL :AnyObject {
    var brandId: Observable<Int?> { get set }
    var areaId: Observable<Int?> { get set }
    var pageIndex: Observable<Int?> { get set }
    var pageSize: Observable<Int?> { get set }
}

