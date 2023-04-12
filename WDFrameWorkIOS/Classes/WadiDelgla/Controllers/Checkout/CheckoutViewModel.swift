//
//  CheckoutViewModel.swift
//  STDobites
//
//  Created by SimpleTouch on 11/25/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import ReactiveKit
//import DAL
//import BLL
import SVProgressHUD
import Kingfisher
import UIKit
//import KashierPaymentSDK

protocol ICheckoutViewModel: IBaseViewModel {
    //MARK: - Variables
    var delegate: ICheckoutViewController? {get set}
    var cart: ISTCheckoutOrderDTODAL? {get set}
    var paymentData: ISTCartPaymentDTODAL? {get set}
    var isSaveCard: Bool? {get set}
    var orderService: OrderServiceBLL? {get set}
    var cartService: CartServiceBLL? {get set}
    var paymentService: STKashierService? {get set}
    var errorModel : IOrderValidationDTOBLL? {get set}
    var calcResponse: ICalOrderResponseDTODAL? {get set}
    var response : STResponseBLL? {get set}
    var customerHistoryId: Int? {get set}
    var paymentMethods: [SelectedPaymentMethodDTO]? {get set}
    var sections: [String]? {get set}
    var selectedPaymentMethodIndex: Int? {get set}
    var titles: [String] {get set}
    var brandService: BrandServiceBLL? {get set}
    //MARK: - Functions
    func viewDidLoad()
    func calcOrder()
    func applyCouponCode(_ couponCode : String)
    func changeCouponCode(_ couponCode: String)
    func makeOrder()
    func getPaymentSubTitle() -> String
    func getOrderByFrontReference()
    var orderId: Int? {get set}
    func handleOnlinePayment(merchantRefNumber: String, referenceNumber: String, status: Bool)
}

class CheckoutViewModel: ICheckoutViewModel{
    //MARK: - Variables
    weak var delegate: ICheckoutViewController?
    var cart: ISTCheckoutOrderDTODAL?
    var orderService: OrderServiceBLL?
    var errorModel : IOrderValidationDTOBLL?
    var calcResponse: ICalOrderResponseDTODAL?
    var cartService: CartServiceBLL?
    var titles = ["address".localized(),"my_items".localized(),"discount".localized(),""]
    var paymentData: ISTCartPaymentDTODAL?
    var isSaveCard: Bool?
    var paymentService: STKashierService?
    var paymentMethods: [SelectedPaymentMethodDTO]? = []
    var sections: [String]? = []
    var customerHistoryId: Int?
    var response: STResponseBLL?
    var selectedPaymentMethodIndex: Int? = -1 {
        didSet{
            self.paymentMethods?.forEach({ (item) in
                item.isSelected = false
            })
            self.paymentMethods?[selectedPaymentMethodIndex!].isSelected = true
            self.cart?.orderPaymentTypeId = self.paymentMethods?[selectedPaymentMethodIndex!].paymentType.orderPaymentId ?? 0
            if paymentMethods?[selectedPaymentMethodIndex!].paymentType == PaymentType.cashOnDelivery {
                self.paymentData = nil
            }
            self.delegate?.onReloadTableView()
        }
    }
    var brandService: BrandServiceBLL?
    var orderId: Int?
    
    //MARK: - Functions
    public  init (cartService: CartServiceBLL, orderService: OrderServiceBLL, paymentService: STKashierService,errorModel: IOrderValidationDTOBLL,brandService:BrandServiceBLL){
        self.orderService = orderService
        self.cartService = cartService
        self.paymentService = paymentService
        self.brandService = brandService
        self.errorModel = errorModel
        self.customerHistoryId = 0
    }
    
    func viewDidLoad() {
        doInBackground {
            self.handleData()
        }
        doOnMain {
            self.calcOrder()
        }
        
    }
    func handleData(){
        self.paymentMethods?.removeAll()
        self.sections?.removeAll()
        // payment methods
        self.paymentMethods?.append(SelectedPaymentMethodDTO(.cashOnDelivery, false))
        self.paymentMethods?.append(SelectedPaymentMethodDTO(.creditCard, false))
        // sections
        if !(cart?.isSelectDeliveryAtStore ?? false){
            sections?.append("address".localized())
        }
        sections?.append("my_items".localized())
        
        
        if let cart = cart, cart.isOnlinePayment ?? false{
            sections?.append("payment_methods".localized())
            if UserDefaults.brandPaymentData != nil {
                doInBackground{
                    self.initKashier()
                }
            }else{
                self.getBrandPaymentData()
            }
        }else{
            selectedPaymentMethodIndex = 0
        }
        sections?.append("discount".localized())
        sections?.append("checkout_cash_details".localized())
    }
    
    func calcOrder() {
        guard let cart = cart else { return}
        self.showHud()
        doInBackground {
            self.orderService?.calcOrder(cart, completion: { (response) in
                doOnMain {
                    self.hideHUD()
                    guard let data = response?.data else {
                        self.errorModel = response?.error?.validateError as? IOrderValidationDTOBLL
                        if response?.error?.APIError != nil {
                            self.delegate?.onError(response?.error?.APIError?.description ?? "")
                        }
                        return
                    }
                    self.calcResponse = data as? ICalOrderResponseDTODAL
                    self.delegate?.onReloadTableView()
                }
            })
            
        }
    }
    
    func applyCouponCode(_ couponCode : String){
        self.cart?.couponCode = couponCode.arToEnDigits
        self.calcOrder()
    }
    func changeCouponCode(_ couponCode: String) {
        self.cart?.couponCode = couponCode.arToEnDigits
        guard couponCode == "" else { return }
        self.calcOrder()
    }
    func makeOrder() {
        guard let cart = cart else { return}
        if cart.frontOrderReferenceId == "" {
            cart.frontOrderReferenceId = self.orderService?.generateFrontOrderReferenceId(forBrandId: K.shared.SELECTED_BRAND?.brandId.value ?? 0, withUserId: UserDefaults.user?.userId.value ?? "")
        }
        cart.referenceTransactionId = UserDefaultsApp.shared.orderPayID
        self.showHud("don't_close_app_message".localized())
        
        doInBackground {
            self.orderService?.makeOrder(cart, completion: { (response) in
                doOnMain {
                    if response?.error?.networkError != nil {
                        doOnMain(deadline: 10.0) {
                            self.hideHUD()
                        }
                    }else{
                        self.hideHUD()
                    }
                    guard let data = response?.data else {
                        self.errorModel = response?.error?.validateError as? IOrderValidationDTOBLL
                        if response?.error?.APIError != nil {
                            self.delegate?.onError(response?.error?.APIError?.description ?? "")
                        }
                        return
                    }
                    if let _data = data as? [String:Any] {
                        if let _customerHistoryId = _data["CustomerHistoryID"] as? Int {
                            self.customerHistoryId = _customerHistoryId
                        }
                        guard  cart.orderPaymentTypeId != PaymentType.cashOnDelivery.orderPaymentId else {
                            self.deleteCart()
                            return
                        }
                        
                        guard  cart.orderPaymentTypeId != PaymentType.creditCard.orderPaymentId else {
                            self.deleteCart()
                            return
                        }
//                        if let orderId = _data["OrderId"] as? Int {
//                            self.handleOnlinePayment(String(orderId))
//                            self.orderId = orderId
//                            self.delegate?.confirmPaymentWithCreditCard()
//                        }
                    }
                    
                }
            })
        }
    }
    func handleOnlinePayment(merchantRefNumber: String, referenceNumber: String, status: Bool) {
//        #warning("check from code")
//        self.delegate?.onError("Online Payment not available right now".localized())
//        return
        guard let _ = paymentData?.cardToken else {
            self.confirmOnlinePaymentForOrder(transactionID: referenceNumber, merchanOrderId: merchantRefNumber, status: status)
            return
        }
//        self.payWithToken(orderId)
    }
    func deleteCart(){
        self.cartService?.deleteCart(completion: { (success) in
            if success{
                self.delegate?.openReceipt(self.customerHistoryId ?? 0)
            }
        })
    }
//    func payWithToken(_ orderId: String) {
//        self.showHud(R.string.localizable.donT_close_app_during_purchasing_message())
//
//        doInBackground {
//            self.paymentService?.payWithPermToken(shopperReference: UserDefaults.user?.userId.value ?? "", orderId: orderId, amount: "\(String(format: "%.2f", self.calcResponse?.totalPay.value ?? 0))", cardToken: self.paymentData?.cardToken?.token ?? "", completion: { (result,error) in
//                doOnMain {
//                    self.hideHUD()
//                    guard let data = result else {
//
//                        if let error = error {
//                            self.delegate?.onError(error)
//                        }
//                        self.confirmOnlinePaymentForOrder(nil, orderId, false)
//                        return
//                    }
//                    if let model = data as? PaymentResponse {
//                        self.confirmOnlinePaymentForOrder(model, orderId, true)
//                    }
//
//                }
//            })
//
//
//        }
//    }
//    func payWithCard(_ orderId: String) {
//        self.showHud(R.string.localizable.donT_close_app_during_purchasing_message())
//        doInBackground {
//            self.paymentService?.payWithCard(cardData: self.paymentData?.cardData! as! ICardDTODAL, orderId: orderId, amount: "\(String(format: "%.2f", self.calcResponse?.totalPay.value ?? 0))", shopperReference: UserDefaults.user?.userId.value ?? "", shouldSaveCard: self.isSaveCard ?? false, completion: { (result,error) in
//                doOnMain {
//                    self.hideHUD()
//                    guard let data = result else {
//                        if let error = error {
//                            self.delegate?.onError(error)
//                        }
//                        self.confirmOnlinePaymentForOrder(orderId, false)
//                        return
//                    }
////                    if let model = data as? PaymentResponse {
////                        self.confirmOnlinePaymentForOrder(orderId, true)
////                    }
//                }
//            })
//
//        }
//    }
    
    func confirmOnlinePaymentForOrder(transactionID: String?, merchanOrderId: String?, status: Bool) {
        self.showHud("don't_close_app_during_purchasing_message".localized())
        doInBackground {
            let payment = ConfirmPaymentDTODAL(transactionId: transactionID ?? "", merchanOrderId: merchanOrderId ?? "", orderId: self.orderId?.string ?? "", status: status)
            self.orderService?.confirmOnLinePaymentForOrder(payment, completion: { (response) in
                doOnMain {
                    self.hideHUD()
                    guard let data = response?.data else {
                        self.errorModel = response?.error?.validateError as? IOrderValidationDTOBLL
                        if response?.error?.APIError != nil {
                            self.delegate?.onError(response?.error?.APIError?.description ?? "")
                        }
                        return
                    }
                    if transactionID != nil && status {
                        self.deleteCart()
                    }
                }
            })

        }
    }
    
    func getPaymentSubTitle() -> String {
        if self.paymentData?.cardData != nil {
            var title = "\(self.paymentData?.cardData?.cardNumber.value ?? "")" + " - "
            title += String((self.paymentData?.cardData?.cardExpiryDate.value ?? "").prefix(2)) + "/"
            title += String((self.paymentData?.cardData?.cardExpiryDate.value ?? "").suffix(2))
            return title
            
        }else if self.paymentData?.cardToken != nil {
            return "\(self.paymentData?.cardToken?.cardNumber ?? "") - \(self.paymentData?.cardToken?.cardExpiryMonth ?? "")/\(self.paymentData?.cardToken?.cardExpiryYear ?? "")"
        }else{
            return ""
        }
        
    }
    func getBrandPaymentData() {
        guard let cart = cart else { return}
        //        self.showHud()
        doInBackground {
            self.brandService?.getBrandPaymentData(String(cart.selectedAreaId),cart.brandId, completion: { (response) in
                doInBackground {
                    self.initKashier()
                }
            })
        }
    }
    func initKashier(){
        print("Init Kashier")
//        Kashier.initialize(
//            merchantId: UserDefaults.brandPaymentData?.merchantId.value ?? "",
//            apiKey: UserDefaults.brandPaymentData?.apiKey.value ?? "",
//            sdkMode: Config.kashierSDKMode,
//            currency: "EGP",
//            displayLang: K.shared.APP_LANGUAGE == SupportedLanguage.Arabic.rawValue ? KASHIER_DISPLAY_LANG.AR : KASHIER_DISPLAY_LANG.EN)
    }
    func getOrderByFrontReference() {
          guard let frontOrderReferenceId = self.cart?.frontOrderReferenceId,frontOrderReferenceId != "" else { return }
          self.showHud()
          doInBackground {
              self.orderService?.getOrderByFrontReference(frontOrderReferenceId, completion: { (response) in
                  doOnMain {
                      self.hideHUD()
                      guard let data = response?.data as? OrderByFrontRefernceDTODAL else {
                          self.hideHUD()
//                          self.delegate?.onError(R.string.localizable.error_happen_message())
                          return
                      }
                      guard let status = data.status.value ,status else {
//                          self.delegate?.onError(response?.error?.networkError?.description ?? "")
                          return }
                      // cash on delivery
                      if self.cart?.orderPaymentTypeId == PaymentType.cashOnDelivery.orderPaymentId {
                          self.customerHistoryId = data.customerHistoryId.value
                          self.deleteCart()
                      }else {
                          self.handleOnlinePayment(merchantRefNumber: "", referenceNumber: String(data.orderHeaderId.value ?? 0), status: false)
                      }
                      
                  }
              })
          }
      }
}
