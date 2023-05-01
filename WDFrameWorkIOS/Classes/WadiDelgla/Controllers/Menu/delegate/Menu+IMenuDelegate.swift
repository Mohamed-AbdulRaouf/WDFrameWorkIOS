//
//  Menu+IMenuDelegate.swift
//  STDobites
//
//  Created by SimpleTouch on 11/13/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
import Kingfisher
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
        // stop display background from server for a while 
//        if let imageUrl = URL(string: K.shared.SELECTED_BRAND?.backgroundAdsImage.value?.replacingOccurrences(of: "http", with: "https") ?? "") {
//            let resource = ImageResource(downloadURL: imageUrl, cacheKey: K.shared.SELECTED_BRAND?.backgroundAdsImage.value)
//            self.backgroundAdsImage.kf.setImage(with: resource)
//        } else {
//            self.backgroundAdsImage.image = UIImage(named: "defaultimg")
//        }
        self.setCountOfCartToLbl()
        self.getCattItemsCountBadget()
    }
    
    func setCountOfCartToLbl() {
        if let count = UserDefaults.order?.cartItems.count {
            self.cartCountLbl.text = "\(count)"
        } else {
            self.cartCountLbl.text = "0"
        }
    }
   
}
