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
class CheckOutViewController: STUIViewController,IBaseController {
    
    // MARK: - Properties
    typealias T = ICheckoutViewModel
    var viewModel: ICheckoutViewModel?
    private var observer: NSObjectProtocol?

    // MARK: - IBOutlets
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var finalizeOrderButton: UIButton!
    
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
            let vc = StoryboardScene.Payment.creditCardViewController.instantiate()
            vc.viewModel?.sourceDelegate = self
            self.navigationController?.pushViewController(vc)
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
