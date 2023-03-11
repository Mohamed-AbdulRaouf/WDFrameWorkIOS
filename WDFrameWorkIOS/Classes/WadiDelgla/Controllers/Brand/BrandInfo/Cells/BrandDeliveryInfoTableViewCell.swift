//
//  BrandDeliveryInfoTableViewCell.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 11/5/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
//import DAL
class BrandDeliveryInfoTableViewCell: UITableViewCell ,IBaseTableViewCell{
    typealias T = IBrandDTODAL

    @IBOutlet weak var headerTitleLabel: UILabel!
//    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var workingRangeLabel: UILabel!
    @IBOutlet weak var paymentStatusLabel: UILabel!
//    @IBOutlet weak var deliveryTimeLabel: UILabel!
//    @IBOutlet weak var deliveryFeesLabel: UILabel!
    @IBOutlet weak var minDeliveryLabel: UILabel!
    var call : (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(_ model: IBrandDTODAL) {
        self.setupHeaderTitle()
        self.selectionStyle = .none
        self.minDeliveryLabel.attributedText = setupLabels(R.string.localizable.min_order_to_deliver(),": \(model.minOrderValueToDeliver.value ?? 0.0) \(model.currency.value ?? "") \(R.string.localizable.minute())")
//        self.deliveryFeesLabel.attributedText = setupLabels(R.string.localizable.delivery_fees(), ": \(model.deliveryFeesAmount.value ?? 0.0) \(model.currency.value ?? "")")
        
        
//        self.deliveryTimeLabel.attributedText = setupLabels(R.string.localizable.delivery_time(), ": \(model.estimatedDeliveryTime.value ?? 0) \(R.string.localizable.minute())")
        let isonlinePayment = model.isOnLinePayment.value == nil  ? R.string.localizable.online_payment() : R.string.localizable.no_online_payment()
        self.paymentStatusLabel.attributedText = setupLabels("\(isonlinePayment)", "")
        if model.openTime.value != "" && model.closeTime.value != "" {
            self.workingRangeLabel.attributedText = setupLabels(R.string.localizable.working_hrs(), ": \(model.openTime.value ?? "") - \(model.closeTime.value ?? "")")
        }else{
            self.workingRangeLabel.attributedText = setupLabels(R.string.localizable.working_hrs(), ": 24 \(R.string.localizable.hr())")
        }
//        callButton.setImage(R.image.ic_call(), for: .normal)

//        callButton.isHidden = model.callCenterNumber.value == "" ? true : false
        
        self.paymentStatusLabel.isHidden = true
    }
    @IBAction func onCallTapped(_ sender: Any) {
        self.call!()
    }
    func setupHeaderTitle(){
        
        let attrs1 = [NSAttributedString.Key.font : UIFont(resource: APP_FONT_BOLD, size: 23), NSAttributedString.Key.foregroundColor :COLOR_PRIMARY_TEXT]
        
        let attrs2 = [NSAttributedString.Key.font : UIFont(resource: APP_FONT_BOLD, size: 12), NSAttributedString.Key.foregroundColor : COLOR_PRIMARY_TEXT]
        
        var attributedString1 = NSMutableAttributedString(string:R.string.localizable.delivery(), attributes:attrs1)
        
        var attributedString2 = NSMutableAttributedString(string: "\n \(R.string.localizable.info())", attributes:attrs2)
        
        if K.shared.APP_LANGUAGE == "ar" {
            attributedString1 = NSMutableAttributedString(string:R.string.localizable.info(), attributes:attrs2)
            
            attributedString2 = NSMutableAttributedString(string: "\n \(R.string.localizable.delivery())", attributes:attrs1)
            
        }
        
        attributedString1.append(attributedString2)
        self.headerTitleLabel.attributedText = attributedString1
        
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
