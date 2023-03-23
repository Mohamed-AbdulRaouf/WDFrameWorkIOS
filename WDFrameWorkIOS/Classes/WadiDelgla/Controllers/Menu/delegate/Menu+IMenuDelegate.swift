//
//  Menu+IMenuDelegate.swift
//  STDobites
//
//  Created by SimpleTouch on 11/13/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
//import Toast_Swift
//import DAL

// MARK: - IMenuViewController Protocol
extension MenuViewController : IMenuViewController{
    func onReloadTableView() {
        self.tableView.reloadData()
    }
    func onReloadCategoryCollectionView() {
        self.collectionView.reloadData()
    }
    func showProductViewController(_ item : IMenuItemsDTODAL){
        let vc = StoryboardScene.Menu.productViewController.instantiate()
        vc.viewModel?.product = item.copy() as? IMenuItemsDTODAL
        self.navigationController?.pushViewController(vc)
    }
    func onShowClearCartAlert(_ completion: @escaping ((Bool) -> Void)) {
        let alertVC = UIAlertController(title: R.string.localizable.changing_brand_error_title(), message: R.string.localizable.changing_brand_error_msg(), preferredStyle: .actionSheet)
        let clearAction = UIAlertAction(title: R.string.localizable.clear_and_add(), style: .destructive) { (pressed) in
            self.viewModel?.cartService?.deleteCart(completion: { (response) in
                    completion(response)
            })
        }
        let cancelAction = UIAlertAction(title: R.string.localizable.cancel(), style: .cancel) { (_) in
            completion(false)
        }
        alertVC.addAction(clearAction)
        alertVC.addAction(cancelAction)
        present(alertVC, animated: true, completion: nil)
    }
    func updateBageCount() {
        self.getCattItemsCountBadget()
    }
   
}
