//
//  CountryService.swift
//  BLL
//
//  Created by SimpleTouch on 11/15/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
import Alamofire
////import DAL
//MARK:- Brand
public protocol CountryServiceBLL :AnyObject {
    func getAllAvailableCountries(completion: @escaping onSuccessBLL)
    func getBrandAvailableCountries(_ brandId: Int,completion: @escaping onSuccessBLL)
}

