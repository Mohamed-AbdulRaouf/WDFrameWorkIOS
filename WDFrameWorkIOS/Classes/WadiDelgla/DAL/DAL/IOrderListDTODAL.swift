//
//  IOrderListDTO.swift
//  DAL
//
//  Created by Nermeen Mohamed on 10/31/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol  IOrderListDTODAL:AnyObject {
    var totalCount: Observable<Int?> {get set}
    var items: Observable<[OrderDTODAL]?> {get set}
}
