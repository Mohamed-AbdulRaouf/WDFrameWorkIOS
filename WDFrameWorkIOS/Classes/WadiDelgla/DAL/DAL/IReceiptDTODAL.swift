//
//  IReceiptDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/14/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol  IReceiptDTODAL:AnyObject {
    var orderDetails: Observable<IOrderDetailsDTODAL?> { get set }
    var orderItems: Observable<[IOrderItemDTODAL]?> {get set}
}
