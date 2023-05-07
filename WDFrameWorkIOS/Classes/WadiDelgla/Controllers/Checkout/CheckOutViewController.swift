//
//  CheckOutViewController.swift
//  STDobites
//
//  Created by SimpleTouch on 11/25/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
import SVProgressHUD
import AcceptSDK

class CheckOutViewController: STUIViewController,IBaseController {
    
    // MARK: - Properties
    typealias T = ICheckoutViewModel
    var viewModel: ICheckoutViewModel?
    private var observer: NSObjectProtocol?

    // MARK: - IBOutlets
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var finalizeOrderButton: UIButton!
    @IBOutlet weak var finalizeIconImageView: UIImageView!
    // MARK: - FawryPay Var
//    let serverURL = "https://atfawry.fawrystaging.com/"
//    let merchantCode = "+/IAAY2nothN6tNlekupwA=="
//    let secureKey = "4b815c12-891c-42ab-b8de-45bd6bd02c3d"
//    let customerProfileId = "7117"
    // MARK: - Paymob Var
    let accept = AcceptSDK()

    let repo = RepositoryPaymob(network: MainNetworkPaymob())
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // paymob delegate
        self.accept.delegate = self
        //bind UI
        self.setupTableView()
        self.finalizeOrderButton.setTitle("finalize_order".localized(), for: .normal)
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
        self.title = "checkout".localized()
        let backToMainApp = UIBarButtonItem(image: UIImage(named: "exit-to-app"), style: .plain, target: self, action: #selector(backToMainApp))
        self.navigationItem.rightBarButtonItems = [backToMainApp]
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
    
    @objc func backToMainApp() {
        doPostNotification("exit_wdframework")
    }
    
    // MARK: - IBActions
    @IBAction func onFinalizeOrderTapped(_ sender: Any) {
        self.showAlert(withTitle: "", andMessage: "", withActions: [UIAlertAction(title: "ok".localized(), style: .default) { [weak self] _ in
            guard let self = self else {return}
            self.onCheckoutButtonTapped()
        }], withCancel: true)
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
//        self.viewModel?.makeOrder()
//        self.FawryPayment()
        self.authenticationRequest()
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
        let finalizeOrderTitle = self.viewModel?.cart?.orderPaymentTypeId == PaymentType.cashOnDelivery.orderPaymentId ? "\("place_order".localized()) - \(self.viewModel?.calcResponse?.totalPay.value ?? 0.0)" : (self.viewModel?.paymentData?.cardData == nil && self.viewModel?.paymentData?.cardToken == nil ? "\("continue".localized())" : "\("place_order".localized()) - \(self.viewModel?.calcResponse?.totalPay.value ?? 0.0)")
          self.finalizeOrderButton.alpha = self.viewModel?.selectedPaymentMethodIndex == -1 ? 0.5 : 1
          self.finalizeOrderButton.isUserInteractionEnabled = self.viewModel?.selectedPaymentMethodIndex != -1
          self.finalizeOrderButton.setTitle(finalizeOrderTitle, for: .normal)
        self.finalizeOrderButton.isEnabled = true
        self.finalizeIconImageView.image = UIImage(named: "finalize.png", in: .WDFrameworkBundle, with: nil)?.withRenderingMode(.alwaysTemplate)
        self.finalizeIconImageView.tintColor = .black
      }
}
extension CheckOutViewController: IUserAddressProtocol{
    func didSelectAddress(_ address: IUserAddressDTODAL) {
        self.viewModel?.cart?.selectedAddressId = address.id.value ?? 0
        self.viewModel?.cart?.userAddressDetails = "\(address.floorNo.value ?? "0") , \(address.buildingNo.value ?? "0" ) , \(String(describing: address.streetName.value ?? "")) \(String(describing: address.cityName .value ?? "")) \(String(describing: address.areaName.value ?? "")) \(address.addressDescription.value ?? "")"
        self.tableView.reloadData()
    }
}

// MARK: - Paymob AcceptSDKDelegate
extension CheckOutViewController: AcceptSDKDelegate {
    func userDidCancel() {
        debugPrint("")
        self.showToast("transaction_cancelled".localized())
    }

    func paymentAttemptFailed(_ error: AcceptSDKError, detailedDescription: String) {
        debugPrint("paymentAttemptFailed")
        self.showToast("transaction_failed".localized())
    }

    func transactionRejected(_ payData: PayResponse) {
        debugPrint("transactionRejected")
        self.showToast("transaction_failed".localized())
    }

    func transactionAccepted(_ payData: PayResponse) {
        debugPrint("transactionAccepted")
        OrderConstants.shared.orderID = "\(payData.order)"
        OrderConstants.shared.transactionID = "\(payData.id)"
        self.viewModel?.makeOrder()
    }

    func transactionAccepted(_ payData: PayResponse, savedCardData: SaveCardResponse) {
        debugPrint("transactionAccepted")
        OrderConstants.shared.orderID = "\(payData.order)"
        OrderConstants.shared.transactionID = "\(payData.id)"
        self.viewModel?.makeOrder()
    }

    func userDidCancel3dSecurePayment(_ pendingPayData: PayResponse) {
        debugPrint("userDidCancel3dSecurePayment")
        self.showToast("transaction_failed".localized())
    }

}

// MARK: - Paymob Func
extension CheckOutViewController {
    // func
    func authenticationRequest() {
        repo.authenticationRequest { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let res):
                guard let token = res.token else {
                    self.showToast("please_try_again_later".localized())
                    return
                }
                UserDefaultsApp.shared.auth_token = token
                self.orderRegistration()
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.showToast("please_try_again_later".localized())
            }
        }
    }
    
    func orderRegistration() {
        repo.orderRegistration(amount: Double(self.viewModel?.calcResponse?.totalPay.value ?? 0.0)) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let res):
                guard let orderID = res.id else {
                    self.showToast("please_try_again_later".localized())
                    return
                }
                UserDefaultsApp.shared.orderPayID = "\(orderID)"
                self.paymentKeyRequest()
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.showToast("please_try_again_later".localized())
            }
        }
    }
    
    func paymentKeyRequest() {
        repo.paymentKeyRequest(amount: Double(self.viewModel?.calcResponse?.totalPay.value ?? 0.0)) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let res):
                guard let token = res.token else {
                    self.showToast("please_try_again_later".localized())
                    return
                }
                UserDefaultsApp.shared.orderPaymentKey = "\(token)"
                self.paymobPayment()
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.showToast("please_try_again_later".localized())
            }
        }
    }
    
    func paymobPayment() {
        do {
            try accept.presentPayVC(vC: self, paymentKey: UserDefaultsApp.shared.orderPaymentKey, saveCardDefault:
                                        true, showSaveCard: true, showAlerts: true)
        } catch AcceptSDKError.MissingArgumentError(let errorMessage) {
            print(errorMessage)
        }  catch let error {
            print(error.localizedDescription)
        }
    }
}

// MARK: - FawryPay Func
//extension CheckOutViewController {
//    func FawryPayment() {
//        let customerInfo = LaunchCustomerModel(customerName: "Name",
//                                               customerEmail: "email@gmail.com",
//                                               customerMobile: "+0100000000",
//                                               customerProfileId: customerProfileId)
//        
//        let merchantInfo = LaunchMerchantModel(merchantCode: merchantCode,
//                                               merchantRefNum: FrameworkHelper.shared?.getMerchantReferenceNumber(),
//                                               secureKey: secureKey)
//        
//        let chargeInfo = ChargeItemsParamsModel(itemId: "101",
//                                                charge_description: "item description",
//                                                price: Double(self.viewModel?.calcResponse?.totalPay.value ?? 0.0),
//                                                quantity: 1)
//        
//        //total taxes of the items if not included in the item price
////        let taxesInfo = ChargeItemsParamsModel(itemId: "taxes",
////                                               charge_description: "",
////                                               price: 28,
////                                               quantity: 1)
//        
//        
//        let launchModel = FawryLaunchModel(customer: customerInfo,
//                                           merchant: merchantInfo,
//                                           chargeItems: [chargeInfo], // taxesInfo
//                                           signature: nil,
//                                           allowVoucher: false,
//                                           paymentWithCardToken: false,
//                                           paymentMethod: .card)
//        
//        launchModel.skipCustomerInput = true
//        launchModel.skipReceipt = false
//        FrameworkHelper.shared?.launchAnonymousSDK(on: self,
//                                                   launchModel: launchModel,
//                                                   baseURL: serverURL,
//                                                   appLanguage: AppLanguage.English,
//                                                   enable3Ds: true,
//                                                   authCaptureModePayment: false,
//                                                   completionBlock: { (status) in
//            print("Payment Method: completionBlock \(status)")
//        }, onPreCompletionHandler: { (error) in
//            print("Payment Method: onPreCompletionHandler \(error?.message)")
//        }, errorBlock: { (error) in
//            print("Payment Method: errorBlock with CODE:\(error?.errorCode) and MSG:\(error?.message)")
//            self.showToast(error?.message ?? "transaction failed".localized())
//        }, onPaymentCompletedHandler: { (chargeResponse) in
//            print("Payment Method: onPaymentCompletedHandler chargeResponse \(chargeResponse.debugDescription)")
//            if let response = chargeResponse as? PaymentChargeResponse {
//                print(response.merchantRefNumber)
//                print(response.orderStatus)
//            }
//            if let er = chargeResponse as? FawryError{
//                print(er.message)
//                self.showToast(er.message ?? "transaction failed".localized())
//            }
//        }, onSuccessHandler: { (response) in
//            let chargeResponse = response as? PaymentChargeResponse
//            print("Payment Method: onSuccessHandler: \(chargeResponse?.merchantRefNumber)")
//            print("Payment Method: onSuccessHandler: \(chargeResponse?.orderStatus)")
//            self.viewModel?.cart?.isOnlinePayment = true
//            self.viewModel?.cart?.merchantRefNumber = chargeResponse?.merchantRefNumber ?? ""
//            self.viewModel?.cart?.referenceNumber = chargeResponse?.referenceNumber ?? ""
//            self.viewModel?.makeOrder()
//        })
//    }
//}
