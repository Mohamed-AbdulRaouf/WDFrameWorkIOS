//
//  CheckoutItemChoiceCollectionViewCell.swift
//  STDobites
//
//  Created by SimpleTouch on 11/25/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
//import DAL
class CheckoutItemChoiceCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var choicePriceLabel: UILabel!
    @IBOutlet weak var choiceNameLabel: UILabel!
    
    func configureCell(_ model: ISTItemAttributeDTODAL,quantity: Int) {
        if LocalizationSystem.sharedInstance.isCurrentLanguageArabic() {
             self.choiceNameLabel.text =  "\(String(describing: quantity ).enToArDigits) * \(String(describing: model.itemChoiceName ))"
        }else{
            self.choiceNameLabel.text = "\(quantity)x  \(String(describing: model.itemChoiceName ))"

        }
        let price = model.itemChoicePrice * Float(quantity)
        self.choicePriceLabel.text = " \(String(format: "%.2f", price ) + "\(String(describing: model.itemCurrencyCode ))")"
        self.choiceNameLabel.textAlignment = LocalizationSystem.sharedInstance.isCurrentLanguageArabic() ? .right : .left
    }
   
}
