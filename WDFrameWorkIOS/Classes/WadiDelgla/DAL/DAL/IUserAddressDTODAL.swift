//
//  IUserAddressDTO.swift
//  DAL
//
//  Created by Nermeen Mohamed on 11/3/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol  IUserAddressDTODAL:AnyObject {
    var id: Observable<Int?> {get set}
    var countryId: Observable<Int?> {get set}
    var cityId: Observable<Int?> {get set}
    var cityCode: Observable<Int?> {get set}
    var areaId: Observable<Int?> {get set}
    var buildingNo: Observable<String?> {get set}
    var floorNo: Observable<String?> {get set}
    var countryCode: Observable<String?> {get set}
    var companyName: Observable<String?> {get set}
    var countryName: Observable<String?> {get set}
    var cityName: Observable<String?> {get set}
    var areaName: Observable<String?> {get set}
    var streetName: Observable<String?> {get set}
    var addressDescription: Observable<String?> {get set}
    var isAddressValidToUpdate: Observable<Bool?> {get set}
    var addressIndex: Observable<Int?> {get set}
    var brandId: Observable<Int?> {get set}
    var longitude: Observable<Double?> {get set}
    var latitude: Observable<Double?> {get set}
    var addressDetailsText: String {get set}
}
