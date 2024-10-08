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
        self.rewardTitleLabel.text = "Rewards".localized()
        self.balanceTitleLabel.text = "balance".localized()
        self.redeemTitleLabel.text = "redeemed".localized()
        self.loginButton.setTitle("view_balance_info".localized(), for: .normal)
        self.loginView.alpha = UserDefaults.user == nil ? 0.8 : 0.0
        self.loginButton.isHidden = !(UserDefaults.user == nil)
        self.rewardAmountLabel.text = "\(model.equivalentRewardPointsAmount.value ?? 0.0) \(model.currency.value ?? "")"
        self.balanceAmountLabel.text = "\(model.equivalentPointsAmount.value ?? 0.0) \(model.currency.value ?? "")"
        self.redeemAmountLabel.text = "\(model.equivalentRedeemPointsAmount.value ?? 0.0) \(model.currency.value ?? "")"
        
        [rewardTitleLabel,balanceTitleLabel,redeemTitleLabel,rewardAmountLabel,balanceAmountLabel,redeemAmountLabel].forEach { (label) in
            label?.font = APP_FONT_REGULAR12 //UIFont(resource: APP_FONT_REGULAR, size: 12)
            label?.textColor = .darkGray
        }
        
        self.rewardBitesAmountLabel.text = "\(model.totalReword.value ?? 0) \("bites".localized())"
        self.balanceBitesAmountLabel.text = "\(model.currentCustomerPointsInBrand.value ?? 0) \("bites".localized())"
        self.redeemedBitesAmountLabel.text = "\(model.totalRedeemValue.value ?? 0) \("bites".localized())"
        
        [rewardBitesAmountLabel,balanceBitesAmountLabel,redeemedBitesAmountLabel].forEach { (label) in
            label?.font = APP_FONT_BOLD //UIFont(resource: APP_FONT_BOLD, size: 16)
            label?.textColor = COLOR_PRIMARY_TEXT
        }
        
    }
    
    @IBAction func onLoginTapped(_ sender: Any) {
        self.onLoginTap!()
    }
    func setupHeaderTitle(){
        
        let attrs1 = [NSAttributedString.Key.font :APP_FONT_BOLD, NSAttributedString.Key.foregroundColor : COLOR_PRIMARY_TEXT]
        
        let attrs2 = [NSAttributedString.Key.font : APP_FONT_BOLD, NSAttributedString.Key.foregroundColor : COLOR_PRIMARY_TEXT]
        
        var attributedString1 = NSMutableAttributedString(string:"My", attributes:attrs1)
        var attributedString2 = NSMutableAttributedString(string: "\n \("Rewards".localized())", attributes:attrs2)
        
        if LocalizationSystem.sharedInstance.isCurrentLanguageArabic() {
            attributedString1 = NSMutableAttributedString(string:"", attributes:attrs1)
            attributedString2 = NSMutableAttributedString(string: " \("Rewards".localized())", attributes:attrs2)
            
        }
        attributedString1.append(attributedString2)
        self.headerTitleLabel.attributedText = attributedString1
        self.headerTitleLabel.setLineSpacing(lineSpacing: 0.5)
        self.headerTitleLabel.textAlignment = .center
        
        
    }
    func setupLabels(_ str1:String,_ str2:String) -> NSMutableAttributedString {
        let attrs1 = [NSAttributedString.Key.font : APP_FONT_BOLD, NSAttributedString.Key.foregroundColor : COLOR_PRIMARY_TEXT]
        
        let attrs2 = [NSAttributedString.Key.font : APP_FONT_REGULAR, NSAttributedString.Key.foregroundColor : COLOR_PRIMARY_TEXT]
        
        let attributedString1 = NSMutableAttributedString(string:str1, attributes:attrs1)
        
        let attributedString2 = NSMutableAttributedString(string: str2, attributes:attrs2)
        
        attributedString1.append(attributedString2)
        return attributedString1
    }
}
