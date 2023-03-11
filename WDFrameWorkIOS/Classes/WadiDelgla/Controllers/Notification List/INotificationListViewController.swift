//
//  INotificationListViewController.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 11/2/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
protocol INotificationListViewController:ICommonFunc {
    func onReloadTableView()
    func openBrandInfo(_ brandId: String)
}
