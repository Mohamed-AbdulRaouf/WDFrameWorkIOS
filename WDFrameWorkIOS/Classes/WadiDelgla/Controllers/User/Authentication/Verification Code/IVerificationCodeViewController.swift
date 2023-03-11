//
//  IVerificationCodeViewController.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 10/31/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
protocol IVerificationCodeViewController:ICommonFunc {
    func onSuccessSendVerifyCode()
    func onSuccessCheckVerifyCode()
    func onSucessValidateCustomer()
}
