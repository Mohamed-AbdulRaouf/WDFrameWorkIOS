//
//  Product+IProductDelegate.swift
//  STDobites
//
//  Created by SimpleTouch on 11/17/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import UIKit
//import Toast_Swift

// MARK: - IProductViewController Protocol
extension ProductViewController : IProductViewController{
    func onReloadTableView() {
        self.tableView.reloadData()
    }
    func onDismissViewController() {
        self.navigationController?.popViewController(animated: true)
    }
}
