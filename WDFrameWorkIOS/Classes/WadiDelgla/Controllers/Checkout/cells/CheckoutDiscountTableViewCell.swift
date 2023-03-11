//
//  CheckoutDiscountTableViewCell.swift
//  STDobites
//
//  Created by SimpleTouch on 11/25/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
//import DAL
class CheckoutDiscountTableViewCell: UITableViewCell ,IBaseTableViewCell{
    typealias T = ICalOrderResponseDTODAL
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var balanceImageView: UIImageView!
    @IBOutlet weak var couponCodeTextField: UITextField!
    @IBOutlet weak var balanceAmountLabel: UILabel!
    @IBOutlet weak var bitesAmountLabel: UILabel!
    @IBOutlet weak var balanceTitleLabel: UILabel!
    @IBOutlet weak var loyaltyDiscountTextField: UITextField!
    
    var onApplyCouponCode : ((String)->Void)?
    var onChangeCouponCode: ((String)->Void)?
    var onApplyLoyalty : ((String)->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.applyButton.addTarget(self, action: #selector(applyCouponCode(_:)), for: .touchUpInside)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configureCell(_ model: ICalOrderResponseDTODAL) {
        
        

        
        [self.loyaltyDiscountTextField,self.couponCodeTextField].forEach {
            $0?.setPlaceHolderTextColor(.lightGray)
            $0?.textColor = COLOR_PRIMARY_TEXT
            $0?.underlineTextField(COLOR_PRIMARY_TEXT)
            $0?.adjustsFontSizeToFitWidth = true
            $0?.minimumFontSize = 10.0
        }
        self.couponCodeTextField.delegate = self
        self.loyaltyDiscountTextField.delegate = self
        
        self.loyaltyDiscountTextField.placeholder = R.string.localizable.loyalty_discount_amount()
        self.couponCodeTextField.placeholder = R.string.localizable.enter_promo_code()

        
        self.balanceTitleLabel.text = R.string.localizable.balance()
        self.balanceAmountLabel.sizeToFit()
        self.bitesAmountLabel.sizeToFit()
        self.balanceAmountLabel.text = "\(model.equivalentPointsAmount.value ?? 0) \(model.currencyCode.value ?? "")"
        self.bitesAmountLabel.text = "\(model.currentCustomerPointsInBrand.value ?? 0) \(R.string.localizable.bites())"
        
        self.applyButton.setTitle(R.string.localizable.apply(), for: .normal)
        
//        self.couponCodeTextField.text = "\(model.couponCode)"
        var roundedAmount = ""
        if model.redeemPoint.value != 0 {
            roundedAmount = "\(model.loyaltyDiscount.value ?? 0.0)"
        }
        self.loyaltyDiscountTextField.text = "\(roundedAmount)"

        if (K.shared.SELECTED_BRAND?.contractTypeId.value != ContractType.loyality.contractTypeId) || !(model.isCurrentRewardIdValid.value ?? false) || !(model.currentCustomerIsRegistered.value ?? false) {
            [self.loyaltyDiscountTextField,self.balanceTitleLabel,self.balanceAmountLabel,self.bitesAmountLabel,self.balanceImageView].forEach {
                $0?.isHidden = true
            }
        }
       
    }
    
    @IBAction func applyCouponCode(_ sender : UIButton) {
        guard let couponCode = couponCodeTextField.text , couponCodeTextField.text != "" else { return }
        onApplyCouponCode!(couponCode)
    }
    @IBAction func applyLoyaltyDiscount(_ sender : UIButton){
        guard let loyaltyDiscount = loyaltyDiscountTextField.text , loyaltyDiscountTextField.text != "" else { return }
        onApplyLoyalty!(loyaltyDiscount)
    }
}
extension CheckoutDiscountTableViewCell : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == loyaltyDiscountTextField {
            onApplyLoyalty!("")
            return
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
           
          if textField == couponCodeTextField {
                      onChangeCouponCode!(textField.text ?? "")
                  }
       }
}
