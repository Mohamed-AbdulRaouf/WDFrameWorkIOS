//
//  IOrderTypeDTO.swift
//  DAL
//
//  Created by SimpleTouch on 9/28/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol  IOrderTypeDTODAL:AnyObject {
    var itemId: Observable<Int?> {get set}
    var itemTitle: Observable<String?> { get set }
    var itemImage: Observable<String?> {get set}
}
