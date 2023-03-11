//
//  IAdsDTO.swift
//  DAL
//
//  Created by Nermeen Mohamed on 10/28/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol  IAdsDTODAL :AnyObject {
    var id: Observable<Int?> { get set }
    var adsTitle: Observable<String?> { get set }
    var adsDescription: Observable<String?> { get set }
    var imagePath: Observable<String?> { get set }
}
