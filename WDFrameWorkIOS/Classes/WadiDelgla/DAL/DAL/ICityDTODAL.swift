//
//  ICityDTO.swift
//  DAL
//
//  Created by SimpleTouch on 10/24/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol ICityDTODAL {
    var areas: Observable<[SearchItemDTOModelDAL]?> {get set}
 }
