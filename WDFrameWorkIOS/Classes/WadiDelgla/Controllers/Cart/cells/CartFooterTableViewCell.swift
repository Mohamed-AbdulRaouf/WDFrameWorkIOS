//
//  CartFooterTableViewCell.swift
//  STDobites
//
//  Created by SimpleTouch on 11/14/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
//import DAL
class CartFooterTableViewCell: UITableViewCell,IBaseTableViewCell {
    typealias T = ICalOrderResponseDTODAL
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var vatTitlelbl: UILabel!
    @IBOutlet weak var vatValueLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var totalValueLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(_ model: ICalOrderResponseDTODAL) {
        self.quantityLabel.attributedText =  setupLabels("quantity".localized(), ": \(model.itemsCount.value ?? 0) ")
        self.subTotalLabel.attributedText =  setupLabels("sub_total".localized(), ": \(model.subTotal.value ?? 0.0) \(model.currencyCode.value ?? "")")
        let total = (model.subTotal.value ?? 0.0) + (model.taxAmount.value ?? 0.0)
        self.totalValueLbl.text = "\(total) \(model.currencyCode.value ?? "")"
        self.vatTitlelbl.text = "VAT".localized()
        self.totalLbl.text = "Total".localized()
        self.vatValueLbl.text = "\(model.taxAmount.value ?? 0.0) \(model.currencyCode.value ?? "")"
        [self.subTotalLabel, self.quantityLabel, self.vatTitlelbl, self.vatValueLbl, self.totalLbl, self.totalValueLbl].forEach { label in
            label?.font = APP_FONT_BOLD12
        }
    }
    
    func setupLabels(_ str1:String,_ str2:String) -> NSMutableAttributedString {
        let attrs1 = [NSAttributedString.Key.font : APP_FONT_BOLD12, NSAttributedString.Key.foregroundColor :COLOR_PRIMARY_TEXT]
        
        let attrs2 = [NSAttributedString.Key.font : APP_FONT_BOLD12, NSAttributedString.Key.foregroundColor : COLOR_PRIMARY_TEXT]
        
        
        let attributedString1 = NSMutableAttributedString(string:str1, attributes:attrs1)
        
        let attributedString2 = NSMutableAttributedString(string: str2, attributes:attrs2)
        
        attributedString1.append(attributedString2)
        return attributedString1
    }
}
