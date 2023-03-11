//
//  IForgetPasswordViewController.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 10/31/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
//import DAL
protocol IForgetPasswordViewController:ICommonFunc {
    func onUpdateLayout()
    func onSuccess(_ model :IAuthPhoneNumberDTODAL)
}
