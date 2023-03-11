//
//  IBaseOrderDTO.swift
//  DAL
//
//  Created by Nermeen Mohamed on 11/4/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol IBaseOrderDTODAL :AnyObject {
    var orderNumber: Observable<String?> { get set }
    var orderAmount: Observable<Float?> { get set }
    var rewardPoints: Observable<Int?> { get set }
    var redeemedPoints: Observable<Int?> { get set }
    var rating: Observable<Float?> { get set }
    var ratingComment: Observable<String?> { get set }
    var orderDate: Observable<String?> { get set }
}
