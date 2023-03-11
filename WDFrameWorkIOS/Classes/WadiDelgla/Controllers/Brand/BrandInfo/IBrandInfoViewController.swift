//
//  IBrandInfoViewController.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 11/5/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Foundation
protocol IBrandInfoViewController:ICommonFunc {
    func onSuccessLoadBrandInfo()
    func onReloadTableView()
    func onShareButtonTapped()
    func onDirectionTapped()
    func openNotificationList()
    func openLogin()
}
