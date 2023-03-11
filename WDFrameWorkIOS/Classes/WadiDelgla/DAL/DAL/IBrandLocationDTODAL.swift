//
//  IBrandLocationDTO.swift
//  DAL
//
//  Created by Nermeen Mohamed on 10/30/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol  IBrandLocationDTODAL :AnyObject {
    var brandId:   Observable<Int?> { get set }
    var name:      Observable<String?> { get set }
    var latitude:  Observable<Double?> { get set }
    var longitude: Observable<Double?> { get set }
    var brandName: Observable<String?> { get set }
    var openTime: Observable<String?> {get set}
    var closeTime: Observable<String?> {get set}
    var imagePath: Observable<String?> {get set}
    var is24Hour: Observable<Bool?> {get set}
    var inactive: Observable<Bool?> {get set}
    var rating: Observable<Float?> {get set}
    var reviewersNumber: Observable<Int?> {get set}
    var facilities: Observable<[IFacilityDTODAL]?> {get set}
}
