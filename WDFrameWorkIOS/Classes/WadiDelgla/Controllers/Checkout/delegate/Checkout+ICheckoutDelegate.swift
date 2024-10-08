//
//  IChecoutDelegate.swift
//  STDobites
//
//  Created by SimpleTouch on 11/25/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog

// MARK: - ICheckoutViewController Protocol
extension CheckOutViewController : ICheckoutViewController{
    func onReloadTableView() {
        self.tableView.reloadData()
        self.updateFinalizeButton()
    }
    func openLogin(){
        let vc = StoryboardScene.User.loginViewController.instantiate()
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    func openLoyaltyDiscountVC(){
        self.view.endEditing(true)
        guard UserDefaults.user != nil else {
            self.viewModel?.delegate?.openLogin()
            return
        }
        // Create a custom view controller
        let redeemVC = StoryboardScene.Order.redeemViewController.instantiate()
        redeemVC.viewModel?.order = self.viewModel?.calcResponse
        // Create the dialog
        let popup = PopupDialog(viewController: redeemVC,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceDown,
                                tapGestureDismissal: true,
                                panGestureDismissal: false)
        
        // Create first button
        let buttonOne = CancelButton(title: "cancel".localized(), height: 60) {
        }
        
        // Create second button
        let buttonTwo = DefaultButton(title: "apply".localized(), height: 60,dismissOnTap: false) {
            redeemVC.applyRedeem(onComplete: { (applied,redeemPoints) in
                popup.dismiss(animated: true, completion: {
                    if applied {
                        self.viewModel?.cart?.redeemPointsAmount = redeemPoints
                        self.viewModel?.calcOrder()
                    }
                })
            })
        }
        
        // Add buttons to dialog
        buttonTwo.titleLabel?.font = APP_FONT_BOLD12
        popup.addButtons([buttonOne, buttonTwo])
        // Present dialog
        self.present(popup, animated: true, completion: nil)
    }
    func showRedeemVC() {
        self.view.endEditing(true)
        guard UserDefaults.user != nil else {
            self.viewModel?.delegate?.openLogin()
            return
        }
        // Create a custom view controller
        let redeemVC = StoryboardScene.Order.redeemViewController.instantiate()
        redeemVC.viewModel?.order = self.viewModel?.calcResponse
        // Create the dialog
        let popup = PopupDialog(viewController: redeemVC,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceDown,
                                tapGestureDismissal: true,
                                panGestureDismissal: false)
        
        // Create first button
        let buttonOne = CancelButton(title: "cancel".localized(), height: 60) {
        }
        
        // Create second button
        let buttonTwo = DefaultButton(title: "apply".localized(), height: 60,dismissOnTap: false) {
            redeemVC.applyRedeem(onComplete: { (applied,redeemPoints) in
                popup.dismiss(animated: true, completion: {
                    if applied {
                        self.viewModel?.cart?.redeemPointsAmount = redeemPoints
                        self.viewModel?.calcOrder()
                    }
                })
            })
        }
        
        // Add buttons to dialog
        buttonTwo.titleLabel?.font = APP_FONT_BOLD12
        popup.addButtons([buttonOne, buttonTwo])
        // Present dialog
        self.present(popup, animated: true, completion: nil)
    }
    func openReceipt(_ customerHistoryId: Int) {
        let vc = StoryboardScene.Order.receiptViewController.instantiate()
        vc.viewModel?.customerHistoryId = customerHistoryId
        vc.viewModel?.isFromCart = true
        self.navigationController?.pushViewController(vc)
    }
    
    func confirmPaymentWithCreditCard() {
        self.openCreditCardForm()
        //        self.FawryPayment()
    }
    
}

// MARK: - LoginProtocol Protocol
extension CheckOutViewController : LoginProtocol{
    func onUserLogedIn() {
        if let _ = UserDefaults.user{
            self.viewModel?.viewDidLoad()
        }
    }
}
