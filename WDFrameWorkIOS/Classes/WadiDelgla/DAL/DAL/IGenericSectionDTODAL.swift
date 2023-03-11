//
//  IGenericSectionDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/11/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol  IGenericFilterSectionDTO:AnyObject {
    var title: Observable<String?> {get set}
    var items: Observable<[IBaseFilterDTODAL]?> {get set}
 }
