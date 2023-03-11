//
//  IRefferalCodeValidationDTO.swift
//  BLL
//
//  Created by Nermeen Mohamed on 10/30/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol IRefferalCodeValidationDTOBLL : IBaseValidationDTOBLL{ 
    var msgSharedCodeError: Observable<String?> { get  set}
}
