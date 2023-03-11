//
//  INotificationDTO.swift
//  DAL
//
//  Created by Nermeen Mohamed on 11/2/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol INotificationDTODAL :AnyObject {
    var id: Observable<String?> { get set }
    var brandId: Observable<String?> { get set }
    var notificationDate: Observable<String?> { get set }
    var brandLogoPath: Observable<String?> { get set }
    var brandName: Observable<String?> { get set }
    var notificationDescription: Observable<String?> { get set }
    var isReaded: Observable<Bool?> { get set }

}
