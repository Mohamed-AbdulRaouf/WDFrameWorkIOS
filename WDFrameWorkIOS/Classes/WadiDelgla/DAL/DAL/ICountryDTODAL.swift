//
//  CountryDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/10/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//
 
import Foundation
import Bond
public protocol ICountryDTODAL:AnyObject {
    var countryId: Observable<String?> {get set}
    var countryCode: Observable<String?> {get set}
    var dialCode: Observable<String?> {get set}
    var emoji: Observable<String?> {get set}
    var name: Observable<String?> {get set}
    var hintNumber: Observable<String?> {get set}
    var currency: Observable<String?> {get set}
}
