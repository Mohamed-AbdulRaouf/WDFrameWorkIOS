//
//  IBaseBrandDTO.swift
//  DAL
//
//  Created by Nermeen Mohamed on 11/4/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Foundation
import Bond
public protocol IBaseFilterDTODAL :AnyObject {
    var id: Observable<Int?> { get set }
    var code: Observable<String?> { get set }
    var name: Observable<String?> { get set }
    var isSelected: Observable<Bool?> { get set }    

}
