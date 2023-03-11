//
//  IHandleAPIErrors.swift
//  BLL
//
//  Created by SimpleTouch on 3/16/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
////import DAL
public protocol IHandleAPIErrorsBLL : AnyObject {
   static func handleError(errorCode: Int) -> String
}
extension IHandleAPIErrorsBLL {
    static func handleError(errorCode: Int) -> String {
        return ""
    }
}
