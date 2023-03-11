//
//  IBranchDTO.swift
//  DAL
//
//  Created by SimpleTouch on 4/15/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol  IBranchDTODAL:AnyObject {
    var branchId: Observable<Int?> { get set }
    var brandId: Observable<Int?> { get set }
    var code: Observable<String?> { get set }
    var name: Observable<String?> {get set}
    var latitude: Observable<Double?> {get set}
    var longitude: Observable<Double?> {get set}
    var deliveryTime: Observable<String?> {get set}
    var openTime: Observable<String?> {get set}
    var closeTime: Observable<String?> {get set}
    var imagePath: Observable<String?> {get set}
    var is24Hour: Observable<Bool?> {get set}
    var inactive: Observable<Bool?> {get set}
    var brandName: Observable<String?> {get set}
    var rating: Observable<Float?> {get set}
    var reviewersNumber: Observable<Int?> {get set}
    var facilities: Observable<[IFacilityDTODAL]?> {get set}
}
