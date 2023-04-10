//
//  CheckoutDetailsTableViewCell.swift
//  STDobites
//
//  Created by SimpleTouch on 11/25/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
//import DAL
class CheckoutDetailsTableViewCell: UITableViewCell,IBaseTableViewCell {
    typealias T = ICalOrderResponseDTODAL
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalTitleLabel: UILabel!
    @IBOutlet weak var totalDiscountLabel: UILabel!
    @IBOutlet weak var totalDiscountTitleLabel: UILabel!
    @IBOutlet weak var deliveryFeesLabel: UILabel!
    @IBOutlet weak var deliveryFeesTitleLabel: UILabel!
    @IBOutlet weak var vatLabel: UILabel!
    @IBOutlet weak var vatTitleLabel: UILabel!
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var subTotalTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configureCell(_ model: ICalOrderResponseDTODAL) {
        [totalDiscountLabel,totalDiscountTitleLabel,deliveryFeesLabel,deliveryFeesTitleLabel,vatLabel,vatTitleLabel,subTotalLabel,subTotalTitleLabel,].forEach { (label) in
            label?.font = APP_FONT_REGULAR //UIFont(resource: APP_FONT_REGULAR, size: 14)
            label?.textColor = COLOR_PRIMARY_TEXT
        }
        [totalTitleLabel,totalLabel].forEach { (label) in
            label?.font = APP_FONT_BOLD20 //UIFont(resource: APP_FONT_BOLD, size: 20)
            label?.textColor = COLOR_PRIMARY_TEXT
        }
        self.subTotalTitleLabel.text = "sub_total".localized()
        self.vatTitleLabel.text = "VAT".localized()
        self.deliveryFeesTitleLabel.text = "delivery_fees".localized()
        self.totalDiscountTitleLabel.text = "total_discount".localized()
        self.totalTitleLabel.text = "total".localized()

        
        subTotalLabel.text = "\(model.subTotal.value ?? 0.0) \(model.currencyCode.value ?? "")"
        deliveryFeesLabel.text = "\(model.deliveryCharges.value ?? 0.0) \(model.currencyCode.value ?? "")"
        totalLabel.text = "\(model.totalPay.value ?? 0.0) \(model.currencyCode.value ?? "")"
        totalDiscountLabel.text = "\(model.discount.value ?? 0.0) \(model.currencyCode.value ?? "")"
        vatLabel.text = "\(model.taxAmount.value ?? 0.0) \(model.currencyCode.value ?? "")"
        
    }
   
    
}
