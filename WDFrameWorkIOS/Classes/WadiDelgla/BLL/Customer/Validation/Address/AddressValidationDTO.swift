//
//  AddressValidationDTO.swift
//  BLL
//
//  Created by Nermeen Mohamed on 11/3/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public class AddressValidationDTOBLL : NSObject,IAddressValidationDTOBLL{
    public var msgBuildingNoError: Observable<String?> = Observable<String?>(nil)
    
    public var msgStreetNameError: Observable<String?> = Observable<String?>(nil)
    
    public var msgFloorNoError: Observable<String?> = Observable<String?>(nil)
    
    public var msgAreaError: Observable<String?> = Observable<String?>(nil)
    
}
