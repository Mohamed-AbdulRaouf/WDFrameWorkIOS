//
//  INewPasswordDTO.swift
//  DAL
//
//  Created by SimpleTouch on 10/21/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol  INewPasswordDTODAL :AnyObject {
    var oldPassword: Observable<String?> { get set }
    var newPassword: Observable<String?> { get set }
    var confirmPassword: Observable<String?> { get set }
    var currentPassword: Observable<String?> { get set }
}
