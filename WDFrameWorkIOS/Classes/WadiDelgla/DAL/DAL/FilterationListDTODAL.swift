//
//  FilterationListDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/11/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
//import SwiftyJSON
public  class FilterationListDTODAL : IFilterationListDTODAL{
    public var sortList: Observable<[IServiceDTODAL]?> =  Observable<[IServiceDTODAL]?>(nil)
    
    public var cuisineList: Observable<[ICuisinesDTODAL]?> = Observable<[ICuisinesDTODAL]?>(nil)
    
    public var faciltyList: Observable<[IFacilityDTODAL]?> =  Observable<[IFacilityDTODAL]?>(nil)
    
    public var serviceList: Observable<[IServiceDTODAL]?> =  Observable<[IServiceDTODAL]?>(nil)


 
    public init(){}
    enum CodingKeys: String, CodingKey {
        case CuisineApps = "CuisineApps"
        case SortBrandApps = "SortBrandApps"
        case FacilityApps = "FacilityApps"
        case ServiceApps = "ServiceApps"
     }
     public init(json: JSON)  {
         self.sortList.value = json[CodingKeys.SortBrandApps.rawValue].arrayValue.map({try! ServiceDTODAL.init(json: $0)})
        self.cuisineList.value = json[CodingKeys.CuisineApps.rawValue].arrayValue.map({try! CuisinesDTODAL.init(json: $0)})
        self.faciltyList.value = json[CodingKeys.FacilityApps.rawValue].arrayValue.map({try! FacilityDTODAL.init(json: $0)})
        self.serviceList.value = json[CodingKeys.ServiceApps.rawValue].arrayValue.map({try! ServiceDTODAL.init(json: $0)})

    }
}
