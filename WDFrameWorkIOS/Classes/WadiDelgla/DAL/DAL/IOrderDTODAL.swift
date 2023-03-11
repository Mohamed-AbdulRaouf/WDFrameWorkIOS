//
//  IOrderDTO.swift
//  DAL
//
//  Created by Nermeen Mohamed on 10/31/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol  IOrderDTODAL:AnyObject {
    var brandId: Observable<Int?> {get set}
    var brandName: Observable<String?> { get set }
    var brandLogoURL: Observable<String?> { get set }
    var currencyCode: Observable<String?> { get set }
    var customerHistoryId: Observable<Int?> { get set }
    var orderNumber: Observable<Int?> { get set }
    var rating: Observable<Float?> { get set }
    var orderTotal: Observable<Double?> {get set}
    var orderDate: Observable<String?> {get set}
    var isBrandHasRatingItems: Observable<Bool?> { get set }
    var isOrderRatedBefore: Observable<Bool?> { get set }
    var isCanceled: Observable<Bool?> {get set}
    var orderSourceId: Observable<Int?> {get set}
    var orderSourceName: Observable<String?> {get set}
    var orderStatusId: Observable<Int?> {get set}
    var orderStatus: Observable<String?> {get set}
    var color: Observable<String?> {get set}
    var colorCode: Observable<String?> {get set}
    var isOrderStatusValidToRate: Observable<Bool?> {get set}
    var isOrderHasDetails: Observable<Bool?> {get set}

 }
