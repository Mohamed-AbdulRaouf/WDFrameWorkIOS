//
//  RefferalCodeValidationDTO.swift
//  BLL
//
//  Created by Nermeen Mohamed on 10/30/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public class RefferalCodeValidationDTOBLL : NSObject,IRefferalCodeValidationDTOBLL{
    public var msgSharedCodeError: Observable<String?> = Observable<String?>(nil)    
}
