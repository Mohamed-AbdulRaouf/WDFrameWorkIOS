//
//  Home+NotRateOrderDelegate.swift
//  STDobites
//
//  Created by SimpleTouch on 11/27/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import UIKit
//import DAL
import PopupDialog

// MARK: - Home + NotRateOrderDelegate
extension HomeViewController{
    func showNotRatedOrdersList(orderList : IOrderListDTODAL){
        // Create a custom view controller
        let notRatedOrdersVC =  StoryboardScene.Order.notRatedOrdersViewController.instantiate()
        notRatedOrdersVC.viewModel?.orderList =  orderList
        notRatedOrdersVC.onRateOrderTapped = { [weak self] order in
            self?.showRateVC(order: order)
        }
        // Create the dialog
        let popup = PopupDialog(viewController: notRatedOrdersVC,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceDown,
                                tapGestureDismissal: true,
                                panGestureDismissal: false)
        
        // Present dialog
        present(popup, animated: true, completion: nil)
    }
    func showRateVC(order : IOrderDTODAL){
        let vc =  StoryboardScene.Order.rateOrderViewController.instantiate()
        vc.viewModel?.customerHistoryId = order.customerHistoryId.value ?? 0
        self.navigationController?.pushViewController(vc)
    }
    
}
