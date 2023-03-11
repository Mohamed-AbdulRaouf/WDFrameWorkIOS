//
//  IBrandListDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/7/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol  IBrandListDTODAL:AnyObject {
    var totalCount: Observable<Int?> {get set}
    var items: Observable<[BrandDTODAL]?> {get set}
}
