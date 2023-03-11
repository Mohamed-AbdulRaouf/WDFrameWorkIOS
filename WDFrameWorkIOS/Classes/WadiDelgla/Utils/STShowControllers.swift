//
//  STShowControllers.swift
//  STDobites
//
//  Created by SimpleTouch on 10/17/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
//import DAL
//import BLL
func showResetPasswordVC(_ model: IAuthPhoneNumberDTODAL){
    if var topController = UIApplication.topViewController() {
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        let vc = StoryboardScene.User.resetPasswordViewController.instantiate()
        vc.viewModel?.verificationCodeModel = model
        topController.present(vc, animated: true, completion: nil)
    }
    
}
func showVerificationCode(_ mobile: String){
    if var topController = UIApplication.topViewController() {
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        let vc = StoryboardScene.User.verificationCodeViewController.instantiate()
        vc.viewModel?.verificationCodeModel.mobile.value = mobile
        topController.present(vc, animated: true, completion: nil)
    }
    
}
