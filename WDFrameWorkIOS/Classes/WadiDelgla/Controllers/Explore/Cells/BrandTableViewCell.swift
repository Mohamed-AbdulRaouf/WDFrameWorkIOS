//
//  BrandTableViewCell.swift
//  STDobites
//
//  Created by SimpleTouch on 11/6/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
import Cosmos
//import DAL
import Kingfisher
class BrandTableViewCell: UITableViewCell ,IBaseTableViewCell{
    typealias T = IBrandDTODAL
    
    @IBOutlet weak var equivelantCashLabel: UILabel!
    @IBOutlet weak var bitesLabel: UILabel!
    @IBOutlet weak var getHaveLabel: UILabel!
    @IBOutlet weak var brandLogoImageView:UIImageView!
    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var minOrderLabel: UILabel!
    @IBOutlet weak var deliverTimeLabel: UILabel!
    @IBOutlet weak var currentPointsButton: UIButton!
    @IBOutlet weak var onlineOrderLabel: UILabel!
    
    @IBOutlet weak var paymentLabel: UILabel!
    
    var onRegisterToBrand: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configureCell(_ model: IBrandDTODAL) {
        self.selectionStyle = .none
        //        self.itemPosition = position
        
        if let imageUrl = URL(string: model.brandLogoPath.value ?? ""){
            let resource = ImageResource(downloadURL: imageUrl, cacheKey: model.brandLogoPath.value ?? "")
            self.brandLogoImageView.kf.setImage(with: resource)
        } else {
            self.brandLogoImageView.image = UIImage(named: "dobites_splash")
        }
        
        self.brandNameLabel.font = APP_FONT_BOLD15 //UIFont.init(resource: APP_FONT_BOLD, size: 16)
        self.brandNameLabel.textAlignment = LocalizationSystem.sharedInstance.isCurrentLanguageArabic() ? .right : .left
        self.brandNameLabel.text = model.brandName.value ?? ""
        
        
        self.serviceLabel.font = APP_FONT_REGULAR //UIFont.init(resource: APP_FONT_REGULAR, size: 10)
        var facilities = ""
        model.facilities.value?.forEach({ (facility) in
            facilities += " \(facility)"
        })
        self.serviceLabel.text = facilities
        self.deliverTimeLabel.setupAttributes(APP_FONT_BOLD12, withSize: 12, .black, "\("delivery_time".localized()) : ", APP_FONT_BOLD12, withSize: 12, .black, "\(model.estimatedDeliveryTime.value ?? 0) \("minute".localized())")
        
        self.minOrderLabel.setupAttributes(APP_FONT_BOLD10, withSize: 10, COLOR_PRIMARY_TEXT, "\("min_order_to_deliver".localized()): ", APP_FONT_REGULAR, withSize: 10, COLOR_PRIMARY_TEXT, "\(model.minOrderValueToDeliver.value ?? 0) \(model.currency.value ?? "")")
        if model.isOnLinePayment.value ?? false {
            self.paymentLabel.text = "cod_online".localized()
        } else {
            self.paymentLabel.text = "COD".localized()
        }
        
        self.getHaveLabel.font = APP_FONT_REGULAR10
        self.bitesLabel.font = APP_FONT_BOLD13
        self.bitesLabel.textColor = .darkGray
        self.equivelantCashLabel.font = APP_FONT_REGULAR10 //UIFont.init(resource: APP_FONT_REGULAR, size: 10)
        self.equivelantCashLabel.text = "\(model.equivalentPointsAmount.value ?? 0) \(model.currency.value ?? "")"

        [brandNameLabel,serviceLabel,onlineOrderLabel,paymentLabel,getHaveLabel,equivelantCashLabel].forEach { (label) in
            label?.textColor = .black
        }
        if model.isOnlineOrder.value ?? false {
            self.onlineOrderLabel.text = "online_order".localized()
            self.onlineOrderLabel.font = APP_FONT_REGULAR //UIFont.init(resource: APP_FONT_REGULAR, size: 14)
            
        }else{
            self.onlineOrderLabel.text = ""
        }
        
        [getHaveLabel,currentPointsButton,equivelantCashLabel,bitesLabel].forEach { (c) in
            c?.isHidden = (model.contractTypeId.value != ContractType.loyality.contractTypeId)
        }
        
        
        if (model.contractTypeId.value == ContractType.loyality.contractTypeId)
        {
            if model.currentCustomerIsRegistered.value ?? false {
                self.currentPointsButton.isEnabled = false
                self.currentPointsButton.setBackgroundImage(R.image.ic_balance_section(), for: .normal)
                self.getHaveLabel.text = "balance".localized()
                self.bitesLabel.text = "\(Int(model.currentCustomerPointsInBrand.value ?? 0)) \("bites".localized())"
            } else {
                if model.isDefaultRewardValid.value ?? false{
                    self.getHaveLabel.text = "get".localized()
                    self.currentPointsButton.setBackgroundImage(R.image.ic_reward_section(), for: .normal)
                    self.currentPointsButton.isEnabled = true
                    self.bitesLabel.text = "\(Int(model.registerPointsAmount.value ?? 0)) \("bites".localized())"
                    
                }else{
                    [getHaveLabel,currentPointsButton,equivelantCashLabel,bitesLabel].forEach { (cview) in
                        cview?.isHidden = true
                    }
                }
            }
        }
        
        [onlineOrderLabel, paymentLabel].forEach { label in
            label?.font = APP_FONT_BOLD12
        }
        
    }
    @IBAction func onRegisterToBrandTapped(_ sender: Any) {
        self.onRegisterToBrand!()
    }
}
import RswiftResources
extension UILabel{
    func setupAttributes(_ fontResource1 : UIFont,withSize size1 : CGFloat, _ textColor1 : UIColor,_ str1 : String,_ fontResource2: UIFont,withSize size2 : CGFloat, _ textColor2: UIColor,_ str2 : String){
        let attrs1 = [NSAttributedString.Key.font : fontResource1, NSAttributedString.Key.foregroundColor : textColor1]
        
        
        let attrs2 = [NSAttributedString.Key.font : fontResource2, NSAttributedString.Key.foregroundColor : textColor2]
        
        let attributedString1 = NSMutableAttributedString(string:str1, attributes:attrs1 as [NSAttributedString.Key : Any])
        
        let attributedString2 = NSMutableAttributedString(string: str2, attributes:attrs2 as [NSAttributedString.Key : Any])
        
        attributedString1.append(attributedString2)
        self.attributedText = attributedString1
    }
}
