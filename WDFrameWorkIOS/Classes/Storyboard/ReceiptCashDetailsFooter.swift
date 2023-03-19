//
//  ReceiptCashDetailsFooter.swift
//  STDobites
//
//  Created by SimpleTouch on 11/14/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
//import DAL
class ReceiptCashDetailsFooter: UITableViewHeaderFooterView {
    @IBOutlet weak var vatLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var totalTitleLabel: UILabel!
    @IBOutlet weak var totalDiscountLabel: UILabel!
    @IBOutlet weak var totalDiscountTitleLabel: UILabel!
    @IBOutlet weak var vatTitleLabel: UILabel!
    @IBOutlet weak var loyalityDiscountLabel: UILabel!
    @IBOutlet weak var loyalityDiscountTitleLabel: UILabel!
    @IBOutlet weak var deliveryFeesLabel: UILabel!
    @IBOutlet weak var deliveryFeesTitleLabel: UILabel!
    @IBOutlet weak var subTotalTitleLabel: UILabel!
    @IBOutlet weak var subTotalLabel: UILabel!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    func configureCell(_ model: IOrderDetailsDTODAL){
        [subTotalTitleLabel,subTotalLabel,deliveryFeesLabel,deliveryFeesTitleLabel,loyalityDiscountLabel,loyalityDiscountTitleLabel,vatTitleLabel,vatLabel,totalDiscountLabel,totalDiscountTitleLabel].forEach {
            $0?.font = APP_FONT_REGULAR
            $0?.textColor = COLOR_PRIMARY_TEXT
        }
        subTotalTitleLabel.text = R.string.localizable.sub_total()
        subTotalLabel.text = String(format: "%.2f \(String(describing: model.currencyCode.value ?? ""))", model.subTotal.value ?? 0)
        
        deliveryFeesTitleLabel.text = R.string.localizable.delivery_fees()
        deliveryFeesLabel.text = String(format: "%.2f \(model.currencyCode.value ?? "")", model.deliveryFees.value ?? 0)

        loyalityDiscountTitleLabel.text = R.string.localizable.loyalty_discount()
        loyalityDiscountLabel.text = String(format: " %.2f \(model.currencyCode.value ?? "")",model.loyaltyDiscount.value ?? 0)
        

        vatTitleLabel.text = R.string.localizable.vaT()
        vatLabel.text = String(format: "%.2f \(model.currencyCode.value ?? "")",model.totalTax.value ?? 0)

        totalDiscountTitleLabel.text = R.string.localizable.discount()
        totalDiscountLabel.text = String(format: " %.2f \(model.currencyCode.value ?? "")", model.totalDiscount.value ?? 0)
 
        [ totalTitleLabel,totalLabel].forEach {
            $0?.font = APP_FONT_BOLD //UIFont(resource: APP_FONT_BOLD, size: 15)
            $0?.sizeToFit()
            $0?.textColor = COLOR_PRIMARY_TEXT
        }
        totalTitleLabel.text = R.string.localizable.total()
        totalLabel.text = String(format: " %.2f \(model.currencyCode.value ?? "")", model.orderTotal.value ?? 0)
        
     }

}
