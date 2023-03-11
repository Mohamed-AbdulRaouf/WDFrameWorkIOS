//
//  ISearchItemDTO.swift
//  DAL
//
//  Created by SimpleTouch on 10/24/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol  ISearchItemDTODAL:AnyObject  {
    var id: Observable<String?> {get set}
    var name: Observable<String?> { get set }
    var nameAr: Observable<String?> { get set }
}
