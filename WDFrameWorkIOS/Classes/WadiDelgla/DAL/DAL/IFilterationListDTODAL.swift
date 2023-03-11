//
//  IFilterationListDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/11/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol  IFilterationListDTODAL:AnyObject {
    var sortList: Observable<[IServiceDTODAL]?> {get set}
    var cuisineList: Observable<[ICuisinesDTODAL]?> {get set}
    var faciltyList: Observable<[IFacilityDTODAL]?> {get set}
    var serviceList: Observable<[IServiceDTODAL]?> {get set}
}
