//
//  RedeemViewController.swift
//  STDobites
//
//  Created by SimpleTouch on 11/25/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
////import DAL
import Bond
class RedeemViewController: STUIViewController ,IBaseController{
    
    // MARK: - Properties
    typealias T = IRedeemViewModel
    var viewModel: IRedeemViewModel?
    
    // MARK: - IBOutlets
    @IBOutlet weak var maxRedeemLabel: UILabel!
    @IBOutlet weak var minRedeemTitleLabel: UILabel!
    @IBOutlet weak var maxRedeemTitleLabel: UILabel!
    @IBOutlet weak var minRedeemLabel: UILabel!
    @IBOutlet weak var redeemPointTextField: UITextField!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var totalRedeemAmountLabel: UILabel!
    @IBOutlet weak var totalEquivalentLabel: UILabel!
    @IBOutlet weak var totalPointLabel: UILabel!
    @IBOutlet weak var cashTitleLabel: UILabel!
    @IBOutlet weak var balanceTitleLabel: UILabel!
    @IBOutlet weak var loyaltyDiscountLabel: UILabel!
 
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //bind UI
        self.configureUI()
        self.bindingData()
        self.viewModel?.delegate = self
    }

   
    // MARK: - Functions
    func applyRedeem(onComplete:@escaping ((Bool,Int)->Void)){
        self.viewModel?.applyRedeem(self.redeemPointTextField.text, onComplete: onComplete)
    }
    
    func updateDisplayValues(){
        self.totalRedeemAmountLabel.text = self.viewModel?.calculateRedeemAmount(self.redeemPointTextField.text ?? "0")
    }
}

// MARK: - Internal
extension RedeemViewController{
    func configureUI(){
        self.loyaltyDiscountLabel.text = R.string.localizable.loyalty_discount()
        self.balanceTitleLabel.text = R.string.localizable.your_balance()
        self.cashTitleLabel.text = R.string.localizable.equivalent_cash_value()
        self.subtitleLabel.text = R.string.localizable.amount_of_bites_to_be_redeemed()
        self.maxRedeemTitleLabel.text = R.string.localizable.max_redeem()
        self.minRedeemTitleLabel.text = R.string.localizable.min_redeem()
        self.redeemPointTextField.placeholder = R.string.localizable.enter_the_amount_of_points()
        guard let order = self.viewModel?.order else { return }
        
        self.totalPointLabel.text = "\(String(describing: order.currentCustomerPointsInBrand.value ?? 0 ))"
        self.totalEquivalentLabel.text = "\(order.equivalentPointsAmount.value ?? 0.0) \(order.currencyCode.value ?? "")"
        if order.redeemPoint.value != 0 {
            self.redeemPointTextField.text = "\(order.redeemPoint.value ?? 0)"
        }
        self.minRedeemLabel.text = "\(Int(order.minRedeemAmount.value ?? 0.0)) \(R.string.localizable.bites())"
        self.maxRedeemLabel.text = "\(Int(order.maxRedeemAmount.value ?? 0.0)) \(R.string.localizable.bites())"
        self.redeemPointTextField.delegate = self
        redeemPointTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.redeemPointTextField.becomeFirstResponder()
    }
    func bindingData() {
        updateDisplayValues()
    }
}

// MARK: - TextField Delegate
extension RedeemViewController : UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.updateDisplayValues()
    }
}
