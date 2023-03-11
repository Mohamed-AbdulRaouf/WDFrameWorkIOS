//
//  IOrderByFrontRefernceDTO.swift
//  DAL
//
//  Created by SimpleTouch on 12/7/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol  IOrderByFrontRefernceDTODAL:AnyObject {
    var status: Observable<Bool?> {get set}
    var orderHeaderId: Observable<Int?> { get set }
    var customerHistoryId: Observable<Int?> {get set}
}
