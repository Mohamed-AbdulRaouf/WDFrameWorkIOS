//
//  STCartViewModel.swift
//  STDobites
//
//  Created by SimpleTouch on 11/14/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import ReactiveKit
//import DAL
//import BLL
import SVProgressHUD
import Kingfisher
import UIKit
protocol ISTCartViewModel: IBaseViewModel {
    //MARK: - Variables
    var delegate: ISTCartViewController? {get set}
    var cart: ISTCheckoutOrderDTODAL? {get set}
    var cartService: CartServiceBLL? {get set}
    var orderService: OrderServiceBLL? {get set}
    var errorModel : IOrderValidationDTOBLL? {get set}
    var calcResponse: ICalOrderResponseDTODAL? {get set}
    //MARK: - Functions
    func getCartDB()
    func viewDidLoad()
    func calcOrder()
    func validateCheckout()
    func checkout()
    func clearCartDB()
    func increamentItem(_ item: ISTCartItemDTODAL)
    func decreamentItem(_ item: ISTCartItemDTODAL)
    func deleteItem(_ item: ISTCartItemDTODAL)
    func updateComment(_ visualCode: String,withComment comment: String)
    func updateOrderComment(_ comment: String)
    func validateUserLocationWithSelectedCountry()
}

class STCartViewModel: ISTCartViewModel{
    
    //MARK: - Variables
       weak var delegate: ISTCartViewController?
       var cart: ISTCheckoutOrderDTODAL?
       var cartService: CartServiceBLL?
       var orderService: OrderServiceBLL?
       var errorModel : IOrderValidationDTOBLL?
       var calcResponse: ICalOrderResponseDTODAL?
    //MARK: - Functions
      public  init (cartService: CartServiceBLL,orderService: OrderServiceBLL,errorModel: IOrderValidationDTOBLL){
          self.cartService = cartService
          self.orderService = orderService
          self.errorModel = errorModel
      }
    
    func viewDidLoad() {
        self.getCartDB()
        self.delegate?.onReloadTableView()
        self.calcOrder()
    }
    
    func calcOrder() {
        guard let cart = cart,cart.cartItems.count > 0 else { return}
        self.showHud()
        doInBackground {
            self.orderService?.calcOrder(cart, completion: { (response) in
                doOnMain {
                    self.hideHUD()
                    guard let data = response?.data else {
                        self.errorModel = response?.error?.validateError as? IOrderValidationDTOBLL
                        if response?.error?.APIError != nil {
                            if response?.error?.ErrorCode == ErrorsCodeBLL.ItemsInCartChanged.rawValue{
                                self.delegate?.onShowClearCartAlert()
                            }else{
                                self.delegate?.onError(response?.error?.APIError?.description ?? "")
                            }
                        }
                        return
                    }
                    self.calcResponse = data as? ICalOrderResponseDTODAL
                    self.delegate?.onReloadTableView()
                }
            })
        }
    }
    
    func validateUserLocationWithSelectedCountry() {
        LocationManager.sharedInstance.getUserCurrentISOCountry { (countryCode) in
            if let countryCode = countryCode {
                guard countryCode == (UserDefaults.currentAppCountry?.countryCode.value) else {
                    self.delegate?.onError("error_country_location".localized())
                    return
                }
                self.validateCheckout()
            }
        }
    }
    
    func validateCheckout() {
        
        guard let _ = cart else { return}
        if  UserDefaults.user == nil {
            self.delegate?.onError("Please try again and reopen online ordering".localized())
        }else{
            self.checkout()
        }
    }
    
    func checkout() {
        let orderPhone = UserDefaults.orderPhone
        self.cart?.phone2 = orderPhone
        if orderPhone == "" || orderPhone == " " || orderPhone == "0" || orderPhone.count <= 10 || (orderPhone.isValidPhone == false) || (orderPhone.isNumeric == false) {
            self.delegate?.onError("Please check from your phone".localized())
            return
        }
        guard let cart = cart else { return}
        self.showHud()
        doInBackground {
            self.cart?.selectedAddressId = 0
            self.cart?.orderPaymentTypeId = PaymentType.cashOnDelivery.orderPaymentId
            self.cart?.isSelectDeliveryAtStore = false
            self.orderService?.checkout(cart, completion: { (response) in
                doOnMain {
                    self.hideHUD()
                    guard let data = response?.data else {
                        self.errorModel = response?.error?.validateError as? IOrderValidationDTOBLL
                        if response?.error?.APIError != nil {
                            if response?.error?.ErrorCode == ErrorsCodeBLL.InvalidMinOrderToDeliver.rawValue {
                                self.delegate?.onShowToast("min_order_error_msg".localized())
                            }else if response?.error?.ErrorCode == ErrorsCodeBLL.EmptyAddress.rawValue {
                                if !(cart.isBrandDeliveryAtStore ?? false){
                                    self.delegate?.openUserAddresses()
                                }else{
                                    self.delegate?.openOrderTypeVC()
                                }
                            }else if response?.error?.ErrorCode == ErrorsCodeBLL.ItemsInCartChanged.rawValue{
                                self.delegate?.onShowClearCartAlert()
                            }
                            else{
                                self.delegate?.onError(response?.error?.APIError?.description ?? "")
                            }
                        }
                        return
                    }
                    self.calcResponse = data as? ICalOrderResponseDTODAL
                    self.delegate?.onReloadTableView()
                }
            })
        }
    }
    
}
//MARK: - Cart Operation Functions
extension STCartViewModel {
    func getCartDB() {
        self.cart = self.cartService?.getCart()
    }
    func clearCartDB() {
        self.cartService?.deleteCart(completion: { (success) in
            if success{
                self.cart = nil
                self.delegate?.onReloadTableView()
                
            }
        })
    }
    func increamentItem(_ item: ISTCartItemDTODAL) {
        self.showHud()
        self.cartService?.increamentItem(item, completion: { (success) in
            self.getCartDB()
            self.delegate?.onReloadTableView()
            self.hideHUD()
            self.calcOrder()
        })
    }
    func decreamentItem(_ item: ISTCartItemDTODAL) {
        self.showHud()
        self.cartService?.decreamentItem(item, completion: { (success) in
            self.getCartDB()
            self.delegate?.onReloadTableView()
            self.hideHUD()
            self.calcOrder()
        })
    }
    func deleteItem(_ item: ISTCartItemDTODAL) {
        self.showHud()
        self.cartService?.deleteItemFromCart(item, completion: { (success) in
            self.getCartDB()
            self.delegate?.onReloadTableView()
            self.hideHUD()
            self.calcOrder()
        })
    }
    func updateComment(_ visualCode: String,withComment comment: String) {
        self.showHud()
        self.cartService?.updateItemComment(visualCode,comment, completion: { (success) in
            self.getCartDB()
            self.delegate?.onReloadTableView()
            self.hideHUD()
            self.calcOrder()
        })
    }
    func updateOrderComment(_ comment: String) {
        self.cartService?.updateOrderComment(comment, completion: { (success) in
            self.getCartDB()
        })
    }
}
