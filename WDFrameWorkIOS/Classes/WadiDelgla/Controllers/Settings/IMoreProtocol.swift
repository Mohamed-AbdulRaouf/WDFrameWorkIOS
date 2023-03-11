//
//  IMoreProtocol.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 10/31/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
protocol IMoreProtocol:ICommonFunc {
    func openLogin()
    func openReferralCode()
    func openLocation()
    func openOrderList()
    func onReloadTable()
    func onSuccessRegisterToBrand()
    func setViewModelDelegates()
    func openAboutDoBites()
    func openBarCode()
    func onShowClearCartByChangingLanguage()
    func openExplore()
    func openCountryList()
    func onShowClearCartAlert(messageText: String, actionButtonText : String, actionButtonClosure: @escaping () -> Void)
}
