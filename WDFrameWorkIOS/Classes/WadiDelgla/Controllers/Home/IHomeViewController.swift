//
//  IHomeViewController.swift
//  STDobites
//
//  Created by SimpleTouch on 11/7/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
//import DAL
protocol IHomeViewController:ICommonFunc {
    func onReloadTable()
    func openLogin()
    func openRanking()
    func openQR()
    func openBranchLocations()
    func openExplore()
    func openNotificationList()
    func showNotRatedOrdersList(orderList : IOrderListDTODAL)
    func showRateVC(order : IOrderDTODAL)
    func updateNotificationCount(_ count: Int)
}
