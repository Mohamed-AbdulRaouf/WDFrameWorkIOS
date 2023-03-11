//
//  ItemChoiceTableViewCell.swift
//  STDobites
//
//  Created by SimpleTouch on 11/14/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
//import DAL
class ItemChoiceTableViewCell: UITableViewCell,IBaseTableViewCell {
    typealias T = IOrderItemChoiceDTODAL
    

    @IBOutlet weak var itemChoicePriceLabel: UILabel!
    @IBOutlet weak var itemChoiceNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(_ model: IOrderItemChoiceDTODAL) {
        let q = "\(model.choiceQTY.value ?? 0)".enToArDigits
        if K.shared.APP_LANGUAGE == "ar"{
            self.itemChoiceNameLabel.text =  "\(q)* \(model.choiceName.value ?? "")"

        }else{
            self.itemChoiceNameLabel.text =  "\(model.choiceQTY.value ?? 0)x  \(model.choiceName.value ?? "")"
        }
        let price = Float(model.choiceQTY.value ?? 0) * (model.choicePrice.value ?? 0.0)
        
        self.itemChoicePriceLabel.text = " \(String(format: "%.2f", price ) + "\(String(describing: model.currencyCode.value ?? "" ))")"
        [self.itemChoiceNameLabel].forEach {
              $0?.textAlignment = K.shared.APP_LANGUAGE == SupportedLanguage.Arabic.rawValue ? .right : .left
        }
    }
}
