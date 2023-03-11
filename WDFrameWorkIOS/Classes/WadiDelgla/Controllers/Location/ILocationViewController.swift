//
//  ILocationViewController.swift
//  STDobites
//
//  Created by SimpleTouch on 11/26/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
//import DAL
protocol ILocationViewController:ICommonFunc {
    func openHome()
    func onSuccessLoadCitiesAndAreas(_ cities: [CityDTODAL])
     func onShowClearCartAlert()
    func onShowClearCartByChangingLanguage()
     func onShowClearCartAlert(messageText: String, actionButtonText : String, actionButtonClosure: @escaping () -> Void)
    func reloadData()
 }

