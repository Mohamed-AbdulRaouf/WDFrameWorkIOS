//
//  IResetPasswordViewController.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 10/31/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Foundation
//import DAL
protocol IResetPasswordViewController:ICommonFunc {
    func onUpdateLayout()
    func onSuccessUpdatePassword()
    func onSuccessSendVerifyCode()
    func onSuccessCheckVerifyCode()
    
}

