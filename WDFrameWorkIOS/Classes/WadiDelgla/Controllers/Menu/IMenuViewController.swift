//
//  IMenuViewController.swift
//  STDobites
//
//  Created by SimpleTouch on 11/13/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
//import DAL
protocol IMenuViewController:ICommonFunc {
    func onReloadTableView()
    func onReloadCategoryCollectionView()
    func showProductViewController(_ item : IMenuItemsDTODAL)
    func onShowClearCartAlert(_ completion: @escaping ((Bool) -> Void))
    func updateBageCount()
}
