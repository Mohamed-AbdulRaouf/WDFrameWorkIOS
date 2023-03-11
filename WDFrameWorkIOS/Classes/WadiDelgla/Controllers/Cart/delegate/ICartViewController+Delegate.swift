//
//  ICartViewController+Delegate.swift
//  STDobites
//
//  Created by SimpleTouch on 11/19/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import UIKit
import Toast_Swift
//import DAL
//import AZDialogView
import PopupDialog
// MARK: - ISTCartViewController Protocol
extension STCartViewController : ISTCartViewController{
    
    /// This Function to reload cart tableview
    func onReloadTableView() {
        self.emptyCartView.isHidden = self.viewModel?.cart?.cartItems.count ?? 0 > 0
        self.getCattItemsCountBadget()
        self.tableView.reloadData()
    }
    
    /// this Function to call clear cart DB from offline
    @objc func onClearCartTapped(){
        doOnMain {
            
            let deleteAction =  UIAlertAction(title: R.string.localizable.ok(), style: .default) { (dialog) in
                self.viewModel?.clearCartDB()
            }
                
                self.showAlert(withTitle: R.string.localizable.clear_cart_title(), andMessage: R.string.localizable.clear_cart_mesg(), withActions: [deleteAction],withCancel: true)
        }
    }
    
    /// This Function to open Login Controller
    func openLogin(){
        let vc = StoryboardScene.User.loginViewController.instantiate()
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    /// This Function to open User addresses Controller
    func openUserAddresses(){
        let vc = StoryboardScene.User.userAddressListViewController.instantiate()
        vc.viewModel?.sourceDelegate = self
        self.navigationController?.pushViewController(vc)
    }
    func openOrderTypeVC() {
          let vc = StoryboardScene.Order.orderTypeViewController.instantiate()
          vc.viewModel?.orderTypeDelegate = self
          self.navigationController?.pushViewController(vc)
      }
      func openCheckoutVC() {
          self.viewModel?.cart?.orderPaymentTypeId = PaymentType.cashOnDelivery.orderPaymentId
          let vc = StoryboardScene.Order.checkOutViewController.instantiate()
          vc.viewModel?.cart = self.viewModel?.cart
          self.navigationController?.pushViewController(vc)
      }
    /// This Function to show clear cart from offline dialogue
    func onShowClearCartAlert() {
        let alertVC = UIAlertController(title: "", message: R.string.localizable.items_changed_error_msg(), preferredStyle: .actionSheet)
        let clearAction = UIAlertAction(title: R.string.localizable.clear_cart(), style: .destructive) { (pressed) in
            self.viewModel?.cartService?.deleteCart(completion: { (success) in
                if success{
                    self.viewModel?.getCartDB()
                    self.onReloadTableView()
                }
            })
        }
        alertVC.addAction(clearAction)
        present(alertVC, animated: true, completion: nil)
    }
    func showCommentDialog(_ visualCode: String,_ comment:String){
        // Create a custom view controller
        let commentVC = CommentViewController(nibName: "CommentViewController", bundle: nil)
        commentVC.comment = comment
        // Create the dialog
        let popup = PopupDialog(viewController: commentVC,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceDown,
                                tapGestureDismissal: true,
                                panGestureDismissal: false)
        
        // Create first button
        let buttonOne = CancelButton(title: R.string.localizable.cancel(), height: 60) {
            
        }
        
        // Create second button
        let buttonTwo = DefaultButton(title: R.string.localizable.ok(), height: 60) {
            let updatedComment = commentVC.commentTextView.text == R.string.localizable.comment_description() ? "" : commentVC.commentTextView.text
            self.viewModel?.updateComment(visualCode, withComment: updatedComment ?? "")
            
        }
        
        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo])
        
        // Present dialog
        present(popup, animated: true, completion: nil)
    }
}

// MARK: - ICartOperation Protocol for cart operations such increment / decrement / delete item from cart
extension STCartViewController: ICartOperation{
    /// This Function to increment item count offline
    ///
    /// - Parameter item: item ro be incremented
    func increamentItem(_ item: ISTCartItemDTODAL) {
        self.viewModel?.increamentItem(item)
    }
    /// This Function to decrement item count offline
    ///
    /// - Parameter item: item ro be decremented
    func decreamentItem(_ item: ISTCartItemDTODAL){
        self.viewModel?.decreamentItem(item)
    }
    /// This Function to delete Item from cart
    ///
    /// - Parameter item: item to be deleted from cart
    func deleteItem(_ item: ISTCartItemDTODAL) {
        self.viewModel?.deleteItem(item)
    }
    func updateComment(_ visualCode:String,withComment comment: String) {
        self.showCommentDialog(visualCode, comment)
    }
    func updateOrderComment(_ comment: String) {
        self.viewModel?.updateOrderComment(comment)
    }
}

// MARK: - LoginProtocol Protocol
extension STCartViewController : LoginProtocol{
    func onUserLogedIn() {
        if let _ = UserDefaults.user{
            self.viewModel?.viewDidLoad()
        }
    }
}

// MARK: - IUserAddressProtocol Protocol to select shipping address
extension STCartViewController: IUserAddressProtocol{
    /// This Function to set selected address to continue checkout order
    ///
    /// - Parameter address: address that user selected to continue checkout order
    func didSelectAddress(_ address: IUserAddressDTODAL) {
        self.viewModel?.cart?.selectedAddressId = address.id.value ?? 0
        self.viewModel?.cart?.userAddressDetails = "\(address.floorNo.value ?? "0") , \(address.buildingNo.value ?? "0" ) , \(String(describing: address.streetName.value ?? "")) \(String(describing: address.cityName .value ?? "")) \(String(describing: address.areaName.value ?? "")) \(address.addressDescription.value ?? "")"
        let vc = StoryboardScene.Order.checkOutViewController.instantiate()
        vc.viewModel?.cart = self.viewModel?.cart
        self.navigationController?.pushViewController(vc)
    }
    
}
extension STCartViewController: IOrderTypeProtocol {
    func didSelectOrderType(_ orderTypeId: Int) {
        self.viewModel?.cart?.isSelectDeliveryAtStore = orderTypeId == OrderType.atStore.id
        if orderTypeId == OrderType.online.id {
            self.openUserAddresses()
        }else{
            self.openCheckoutVC()
        }
    }
}
