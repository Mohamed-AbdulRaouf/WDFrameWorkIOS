//
//  CheckOutViewController.swift
//  STDobites
//
//  Created by SimpleTouch on 11/25/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
//import DAL
import SVProgressHUD
import FawryPaySDK

class CheckOutViewController: STUIViewController,IBaseController {
    
    // MARK: - Properties
    typealias T = ICheckoutViewModel
    var viewModel: ICheckoutViewModel?
    private var observer: NSObjectProtocol?

    // MARK: - IBOutlets
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var finalizeOrderButton: UIButton!
    
    // MARK: - FawryPay Var
    let serverURL = "https://atfawry.fawrystaging.com/"
    let merchantCode = "+/IAAY2nothN6tNlekupwA=="
    let secureKey = "4b815c12-891c-42ab-b8de-45bd6bd02c3d"
    let customerProfileId = "7117"
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //bind UI
        self.setupTableView()
        self.finalizeOrderButton.setTitle(R.string.localizable.finalize_order(), for: .normal)
        self.viewModel?.delegate = self
        self.viewModel?.viewDidLoad()
        
//        observer = NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { [unowned self] notification in
//                  // do whatever you want when the app is brought back to the foreground
//                  self.viewModel?.getOrderByFrontReference()
//              }
             
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
           self.updateFinalizeButton()
    }
     override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
         self.viewModel?.getOrderByFrontReference()
     }
    override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           doOnMain { SVProgressHUD.dismiss() }
       }
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.tableViewHeight?.constant = self.tableView.contentSize.height
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let height = min(self.view.bounds.size.height, tableView.contentSize.height)
        self.tableViewHeight.constant = height
        self.view.layoutIfNeeded()
        self.tableView.reloadDataWithAutoSizingCellWorkAround()

    }
    // MARK: - IBActions
    @IBAction func onFinalizeOrderTapped(_ sender: Any) {
        self.onCheckoutButtonTapped()
    }
    func onCheckoutButtonTapped(){
        guard self.viewModel?.cart?.orderPaymentTypeId != PaymentType.cashOnDelivery.orderPaymentId && self.viewModel?.paymentData == nil else {
                  self.viewModel?.makeOrder()
                  return
              }
              
        self.openCreditCardForm()
    }
    func openCreditCardForm(){
        guard self.viewModel?.cart?.orderPaymentTypeId != PaymentType.cashOnDelivery.orderPaymentId else{ return }
        self.viewModel?.makeOrder()
//        self.FawryPayment()
//            let vc = StoryboardScene.Payment.creditCardViewController.instantiate()
//            vc.viewModel?.sourceDelegate = self
//            self.navigationController?.pushViewController(vc)
    }
    deinit {
          if let observer = observer {
              NotificationCenter.default.removeObserver(observer)
          }
      }
}

// MARK: - Internal
extension CheckOutViewController{
    func bindingData() {}
    func updateFinalizeButton(){
          let finalizeOrderTitle = self.viewModel?.cart?.orderPaymentTypeId == PaymentType.cashOnDelivery.orderPaymentId ? "\(R.string.localizable.place_order()) - \(self.viewModel?.calcResponse?.totalPay.value ?? 0.0)" : (self.viewModel?.paymentData?.cardData == nil && self.viewModel?.paymentData?.cardToken == nil ? "\(R.string.localizable.continue())" : "\(R.string.localizable.place_order()) - \(self.viewModel?.calcResponse?.totalPay.value ?? 0.0)")
          self.finalizeOrderButton.alpha = self.viewModel?.selectedPaymentMethodIndex == -1 ? 0.5 : 1
          self.finalizeOrderButton.isUserInteractionEnabled = self.viewModel?.selectedPaymentMethodIndex != -1
          self.finalizeOrderButton.setTitle(finalizeOrderTitle, for: .normal)
          
      }
}
extension CheckOutViewController: IUserAddressProtocol{
    func didSelectAddress(_ address: IUserAddressDTODAL) {
        self.viewModel?.cart?.selectedAddressId = address.id.value ?? 0
        self.viewModel?.cart?.userAddressDetails = "\(address.floorNo.value ?? "0") , \(address.buildingNo.value ?? "0" ) , \(String(describing: address.streetName.value ?? "")) \(String(describing: address.cityName .value ?? "")) \(String(describing: address.areaName.value ?? "")) \(address.addressDescription.value ?? "")"
        self.tableView.reloadData()
    }
}

// MARK: - FawryPay Func
extension CheckOutViewController {
    func FawryPayment() {
        let customerInfo = LaunchCustomerModel(customerName: "Name",
                                               customerEmail: "email@gmail.com",
                                               customerMobile: "+0100000000",
                                               customerProfileId: customerProfileId)
        
        let merchantInfo = LaunchMerchantModel(merchantCode: merchantCode,
                                               merchantRefNum: FrameworkHelper.shared?.getMerchantReferenceNumber(),
                                               secureKey: secureKey)
        
        let chargeInfo = ChargeItemsParamsModel(itemId: "101",
                                                charge_description: "item description",
                                                price: Double(self.viewModel?.calcResponse?.totalPay.value ?? 0.0),
                                                quantity: 1)
        
        //total taxes of the items if not included in the item price
//        let taxesInfo = ChargeItemsParamsModel(itemId: "taxes",
//                                               charge_description: "",
//                                               price: 28,
//                                               quantity: 1)
        
        
        let launchModel = FawryLaunchModel(customer: customerInfo,
                                           merchant: merchantInfo,
                                           chargeItems: [chargeInfo], // taxesInfo
                                           signature: nil,
                                           allowVoucher: false,
                                           paymentWithCardToken: false,
                                           paymentMethod: .card)
        
        launchModel.skipCustomerInput = true
        launchModel.skipReceipt = false
        FrameworkHelper.shared?.launchAnonymousSDK(on: self,
                                                   launchModel: launchModel,
                                                   baseURL: serverURL,
                                                   appLanguage: AppLanguage.English,
                                                   enable3Ds: true,
                                                   authCaptureModePayment: false,
                                                   completionBlock: { (status) in
            print("Payment Method: completionBlock \(status)")
        }, onPreCompletionHandler: { (error) in
            print("Payment Method: onPreCompletionHandler \(error?.message)")
        }, errorBlock: { (error) in
            print("Payment Method: errorBlock with CODE:\(error?.errorCode) and MSG:\(error?.message)")
            self.showToast(error?.message ?? "transaction failed".localized())
        }, onPaymentCompletedHandler: { (chargeResponse) in
            print("Payment Method: onPaymentCompletedHandler chargeResponse \(chargeResponse.debugDescription)")
            if let response = chargeResponse as? PaymentChargeResponse {
                print(response.merchantRefNumber)
                print(response.orderStatus)
            }
            if let er = chargeResponse as? FawryError{
                print(er.message)
                self.showToast(er.message ?? "transaction failed".localized())
            }
        }, onSuccessHandler: { (response) in
            let chargeResponse = response as? PaymentChargeResponse
            print("Payment Method: onSuccessHandler: \(chargeResponse?.merchantRefNumber)")
            print("Payment Method: onSuccessHandler: \(chargeResponse?.orderStatus)")
            self.viewModel?.handleOnlinePayment(merchantRefNumber: chargeResponse?.merchantRefNumber ?? "", referenceNumber: chargeResponse?.referenceNumber ?? "", status: true)
        })
    }
}
