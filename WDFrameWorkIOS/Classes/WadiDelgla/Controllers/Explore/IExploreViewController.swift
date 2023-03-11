//
//  IExploreViewController.swift
//  STDobites
//
//  Created by SimpleTouch on 11/6/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
protocol IExploreViewController:ICommonFunc {
    func onReloadTableView()
    func onReloadServiceCollectionView()
    func setFilter(_ filterText: String)
    func setServiceId(_ serviceId: String)
    func openLogin()
}
