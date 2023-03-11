//
//  IServiceDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/6/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol IServiceDTODAL :AnyObject {
    var id: Observable<String?> { get set }
    var serviceName: Observable<String?> { get set }
    var serviceIcon: Observable<String?> { get set }
}
