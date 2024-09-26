//
//  Menu+IMenuDelegate.swift
//  STDobites
//
//  Created by SimpleTouch on 11/13/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
import Kingfisher

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
        let alertVC = UIAlertController(title: "changing_brand_error_title".localized(), message: "changing_brand_error_msg".localized(), preferredStyle: .actionSheet)
        let clearAction = UIAlertAction(title: "clear_and_add".localized(), style: .destructive) { (pressed) in
            self.viewModel?.cartService?.deleteCart(completion: { (response) in
                    completion(response)
            })
        }
        let cancelAction = UIAlertAction(title: "cancel".localized(), style: .cancel) { (_) in
            completion(false)
        }
        alertVC.addAction(clearAction)
        alertVC.addAction(cancelAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    func updateBageCount() {
        self.setCountOfCartToLbl()
        self.getCattItemsCountBadget()
    }
    
    func setCountOfCartToLbl() {
        if let count = UserDefaults.order?.cartItems.count {
            self.self.cartCountLbl.isHidden = false
            self.cartCountLbl.text = "\(count)"
        } else {
            self.self.cartCountLbl.isHidden = true
            self.cartCountLbl.text = "0"
        }
    }
   
    func vibrationDeviceAfterAddItem() {
        self.vibrationDevice()
    }
    
}
