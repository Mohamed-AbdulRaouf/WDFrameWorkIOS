//
//  GenderType.swift
//  DAL
//
//  Created by SimpleTouch on 10/21/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
public enum GenderTypeDAL : String{
    case female = "F"
    case male = "M"
    case default_gender = "N"
    static func type(_ string:String) -> GenderTypeDAL.RawValue{
        switch string {
        case GenderTypeDAL.male.rawValue:
            return  GenderTypeDAL.male.rawValue
        case GenderTypeDAL.female.rawValue:
            return GenderTypeDAL.female.rawValue
        default:
            return GenderTypeDAL.default_gender.rawValue
        }
    }
}
