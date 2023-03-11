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
//    @IBOutlet weak var ratingView: CosmosView!
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
        
        self.brandNameLabel.font = UIFont.init(resource: APP_FONT_BOLD, size: 16)
        self.brandNameLabel.textAlignment = K.shared.APP_LANGUAGE == "en" ? .left : .right
        self.brandNameLabel.text = model.brandName.value ?? ""
        
        
        self.serviceLabel.font = UIFont.init(resource: APP_FONT_REGULAR, size: 10)
        var facilities = ""
        model.facilities.value?.forEach({ (facility) in
            facilities += " \(facility)"
        })
        self.serviceLabel.text = facilities
        
//        self.ratingView.rating = Double(model.ratingValue.value ?? 0)
//        self.ratingView.text = "(\(model.numberOfUserRate.value ?? 0))"
        
        self.deliverTimeLabel.setupAttributes(APP_FONT_BOLD, withSize: 10, COLOR_PRIMARY_TEXT, "\(R.string.localizable.delivery_time()) : ", APP_FONT_REGULAR, withSize: 10, COLOR_PRIMARY_TEXT, "\(model.estimatedDeliveryTime.value ?? 0) \(R.string.localizable.minute())")
        
        self.minOrderLabel.setupAttributes(APP_FONT_BOLD, withSize: 10, COLOR_PRIMARY_TEXT, "\(R.string.localizable.min_order_to_deliver()): ", APP_FONT_REGULAR, withSize: 10, COLOR_PRIMARY_TEXT, "\(model.minOrderValueToDeliver.value ?? 0) \(model.currency.value ?? "")")
        
        self.paymentLabel.font = UIFont.init(resource: APP_FONT_BOLD, size: 10)
        
        
        if model.isOnLinePayment.value ?? false {
            self.paymentLabel.text = NSLocalizedString("COD & Online", comment: "COD & Online")
        } else {
            self.paymentLabel.text = NSLocalizedString("COD", comment: "COD")
        }
        
        
        self.getHaveLabel.font = UIFont.init(resource: APP_FONT_REGULAR, size: 10)
        
        self.bitesLabel.font = UIFont.init(resource: APP_FONT_BOLD, size: 13)
        self.bitesLabel.textColor = .darkGray
        
        
        
        self.equivelantCashLabel.font = UIFont.init(resource: APP_FONT_REGULAR, size: 10)
        self.equivelantCashLabel.text = "\(model.equivalentPointsAmount.value ?? 0) \(model.currency.value ?? "")"
        
        
        
        [brandNameLabel,serviceLabel,onlineOrderLabel,paymentLabel,getHaveLabel,equivelantCashLabel].forEach { (label) in
            label?.textColor = COLOR_PRIMARY_TEXT
        }
        
        
        if model.isOnlineOrder.value ?? false {
            self.onlineOrderLabel.text = R.string.localizable.cod_online()
            self.onlineOrderLabel.font = UIFont.init(resource: APP_FONT_REGULAR, size: 14)
            
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
                self.getHaveLabel.text = R.string.localizable.balance()
                self.bitesLabel.text = "\(Int(model.currentCustomerPointsInBrand.value ?? 0)) \(R.string.localizable.bites())"
            } else {
                if model.isDefaultRewardValid.value ?? false{
                    self.getHaveLabel.text = R.string.localizable.get()
                    self.currentPointsButton.setBackgroundImage(R.image.ic_reward_section(), for: .normal)
                    self.currentPointsButton.isEnabled = true
                    self.bitesLabel.text = "\(Int(model.registerPointsAmount.value ?? 0)) \(R.string.localizable.bites())"
                    
                }else{
                    [getHaveLabel,currentPointsButton,equivelantCashLabel,bitesLabel].forEach { (cview) in
                        cview?.isHidden = true
                    }
                }
            }
        }
        
        
    }
    @IBAction func onRegisterToBrandTapped(_ sender: Any) {
        self.onRegisterToBrand!()
    }
}
import RswiftResources
extension UILabel{
    func setupAttributes(_ fontResource1 : FontResource,withSize size1 : CGFloat, _ textColor1 : UIColor,_ str1 : String,_ fontResource2: FontResource,withSize size2 : CGFloat, _ textColor2: UIColor,_ str2 : String){
        let attrs1 = [NSAttributedString.Key.font : UIFont(resource: fontResource1, size: size1), NSAttributedString.Key.foregroundColor : textColor1]
        
        
        let attrs2 = [NSAttributedString.Key.font : UIFont(resource: fontResource2, size: size2), NSAttributedString.Key.foregroundColor : textColor2]
        
        let attributedString1 = NSMutableAttributedString(string:str1, attributes:attrs1 as [NSAttributedString.Key : Any])
        
        let attributedString2 = NSMutableAttributedString(string: str2, attributes:attrs2 as [NSAttributedString.Key : Any])
        
        attributedString1.append(attributedString2)
        self.attributedText = attributedString1
    }
}
