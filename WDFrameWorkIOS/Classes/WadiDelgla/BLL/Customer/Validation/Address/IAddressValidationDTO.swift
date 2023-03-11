//
//  IAddressValidationDTO.swift
//  BLL
//
//  Created by Nermeen Mohamed on 11/3/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol IAddressValidationDTOBLL : IBaseValidationDTOBLL { 
    var msgBuildingNoError : Observable<String?> { get  set}
    var msgStreetNameError : Observable<String?> { get  set}
    var msgFloorNoError : Observable<String?> { get set }
    var msgAreaError : Observable<String?> { get set }    
}
