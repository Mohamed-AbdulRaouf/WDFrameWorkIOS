//
//  IUserUpdateableDTO.swift
//  DAL
//
//  Created by SimpleTouch on 10/21/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol  IUserUpdateableDTODAL:AnyObject {
    var firstName: Observable<String?> { get set }
    var lastName: Observable<String?> { get set }
    var email: Observable<String?> { get set }
    var birthday: Observable<Int?> {get set}
    var birthmonth: Observable<Int?> {get set}
    var gender: Observable<String?> { get set }
}
