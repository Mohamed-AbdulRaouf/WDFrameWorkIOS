//
//  BrandRewardInfoTableViewCell.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 11/5/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
//import DAL
class BrandRewardInfoTableViewCell: UITableViewCell ,IBaseTableViewCell{
    typealias T = IBrandDTODAL

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var redeemAmountLabel: UILabel!
    @IBOutlet weak var redeemedBitesAmountLabel: UILabel!
    @IBOutlet weak var redeemTitleLabel: UILabel!
    @IBOutlet weak var balanceAmountLabel: UILabel!
    @IBOutlet weak var balanceBitesAmountLabel: UILabel!
    @IBOutlet weak var balanceTitleLabel: UILabel!
    @IBOutlet weak var rewardAmountLabel: UILabel!
    @IBOutlet weak var rewardBitesAmountLabel: UILabel!
    @IBOutlet weak var rewardTitleLabel: UILabel!
    @IBOutlet weak var headerTitleLabel: UILabel!
    var onLoginTap : (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(_ model:IBrandDTODAL) {
         loginButton.layer.cornerRadius = 10
        self.selectionStyle = .none

        self.setupHeaderTitle()
        self.rewardTitleLabel.text = R.string.localizable.rewards()
        self.balanceTitleLabel.text = R.string.localizable.balance()
        self.redeemTitleLabel.text = R.string.localizable.redeemed()
        self.loginButton.setTitle(R.string.localizable.view_balance_info(), for: .normal)
        self.loginView.alpha = UserDefaults.user == nil ? 0.8 : 0.0
        self.loginButton.isHidden = !(UserDefaults.user == nil)
        
        
        
        self.rewardAmountLabel.text = "\(model.equivalentRewardPointsAmount.value ?? 0.0) \(model.currency.value ?? "")"
        self.balanceAmountLabel.text = "\(model.equivalentPointsAmount.value ?? 0.0) \(model.currency.value ?? "")"
        self.redeemAmountLabel.text = "\(model.equivalentRedeemPointsAmount.value ?? 0.0) \(model.currency.value ?? "")"
        
        [rewardTitleLabel,balanceTitleLabel,redeemTitleLabel,rewardAmountLabel,balanceAmountLabel,redeemAmountLabel].forEach { (label) in
            label?.font = UIFont(resource: APP_FONT_REGULAR, size: 12)
            label?.textColor = .darkGray
        }
        
        self.rewardBitesAmountLabel.text = "\(model.totalReword.value ?? 0) \(R.string.localizable.bites())"
        self.balanceBitesAmountLabel.text = "\(model.currentCustomerPointsInBrand.value ?? 0) \(R.string.localizable.bites())"
        self.redeemedBitesAmountLabel.text = "\(model.totalRedeemValue.value ?? 0) \(R.string.localizable.bites())"
        
        [rewardBitesAmountLabel,balanceBitesAmountLabel,redeemedBitesAmountLabel].forEach { (label) in
            label?.font = UIFont(resource: APP_FONT_BOLD, size: 16)
            label?.textColor = COLOR_PRIMARY_TEXT
        }
        
    }
    
    @IBAction func onLoginTapped(_ sender: Any) {
        self.onLoginTap!()
    }
    func setupHeaderTitle(){
        
        let attrs1 = [NSAttributedString.Key.font :UIFont(resource: APP_FONT_BOLD, size: 13), NSAttributedString.Key.foregroundColor : COLOR_PRIMARY_TEXT]
        
        let attrs2 = [NSAttributedString.Key.font : UIFont(resource: APP_FONT_BOLD, size: 25), NSAttributedString.Key.foregroundColor : COLOR_PRIMARY_TEXT]
        
        var attributedString1 = NSMutableAttributedString(string:"My", attributes:attrs1)
        var attributedString2 = NSMutableAttributedString(string: "\n \(R.string.localizable.rewards())", attributes:attrs2)
        
        if K.shared.APP_LANGUAGE == "ar"{
            attributedString1 = NSMutableAttributedString(string:"", attributes:attrs1)
            attributedString2 = NSMutableAttributedString(string: " \(R.string.localizable.rewards())", attributes:attrs2)
            
        }
        
        
        attributedString1.append(attributedString2)
        
        self.headerTitleLabel.attributedText = attributedString1
        self.headerTitleLabel.setLineSpacing(lineSpacing: 0.5)
        self.headerTitleLabel.textAlignment = .center
        
        
    }
    func setupLabels(_ str1:String,_ str2:String) -> NSMutableAttributedString {
        let attrs1 = [NSAttributedString.Key.font : UIFont(resource: APP_FONT_BOLD, size: 14), NSAttributedString.Key.foregroundColor : COLOR_PRIMARY_TEXT]
        
        let attrs2 = [NSAttributedString.Key.font : UIFont(resource: APP_FONT_REGULAR, size: 12), NSAttributedString.Key.foregroundColor : COLOR_PRIMARY_TEXT]
        
        let attributedString1 = NSMutableAttributedString(string:str1, attributes:attrs1)
        
        let attributedString2 = NSMutableAttributedString(string: str2, attributes:attrs2)
        
        attributedString1.append(attributedString2)
        return attributedString1
    }
}
