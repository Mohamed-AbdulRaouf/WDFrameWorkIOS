//
//  ICheckoutViewController.swift
//  STDobites
//
//  Created by SimpleTouch on 11/25/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
//import DAL
protocol ICheckoutViewController:ICommonFunc {
    func onReloadTableView()
    func openLogin()
    func openLoyaltyDiscountVC()
    func openReceipt(_ customerHistoryId: Int)
}

