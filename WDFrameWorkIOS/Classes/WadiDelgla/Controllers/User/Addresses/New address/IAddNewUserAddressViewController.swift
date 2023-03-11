
//
//  IAddNewUserAddressViewController.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 11/3/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation

protocol IAddNewUserAddressViewController:ICommonFunc {
    func successUpdateUserAddress()
    func successAddNewAddress()
    func onUpdateLayout()
    func onSuccessLoadCitiesAndAreas(_ cities: [CityDTODAL])
    
}

 
