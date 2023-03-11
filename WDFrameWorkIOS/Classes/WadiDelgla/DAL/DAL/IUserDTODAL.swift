//
//  IUserDTO.swift
//  DAL
//
//  Created by SimpleTouch on 10/9/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol  IUserDTODAL:AnyObject {
    var userId: Observable<String?> {get set}
    var code: Observable<String?> { get set }
    var firstName: Observable<String?> { get set }
    var lastName: Observable<String?> { get set }
    var mobile: Observable<String?> { get set }
    var email: Observable<String?> { get set }
    var password: Observable<String?> { get set }
    var birthday: Observable<Int?> {get set}
    var birthmonth: Observable<Int?> {get set}
    var birthyear: Observable<Int?> {get set}
    var gender: Observable<String?> { get set }
    var mobileValidated: Observable<Bool?> { get set }
    var profileImageName: Observable<String?> {get set}
    var token: Observable<String?> {get set}
    var userName: Observable<String?> {get set}
    var balance : Observable<Double?> {get set}
}
