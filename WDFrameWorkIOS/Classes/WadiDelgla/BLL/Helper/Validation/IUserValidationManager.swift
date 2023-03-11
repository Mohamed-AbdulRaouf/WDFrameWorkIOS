//
//  IUserValidationManager.swift
//  BLL
//
//  Created by SimpleTouch on 11/17/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
////import DAL
public protocol IUserValidationManagerBLL : AnyObject {
        associatedtype T
       associatedtype M
       func validate(model: T) -> Bool
       var errorViewModel : M? { get set }
       init(errorModel: M,hintNumber: String?)
}
