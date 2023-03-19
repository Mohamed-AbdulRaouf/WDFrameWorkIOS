//
//  ReceiptMainHeaderView.swift
//  STDobites
//
//  Created by SimpleTouch on 11/14/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
//import DAL
class ReceiptMainHeaderView: UITableViewHeaderFooterView {
    
    
//    @IBOutlet weak var priceLabel: UILabel!
//    @IBOutlet weak var nameLabel: UILabel!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configureCell(_ model: IOrderItemDTODAL){
        if K.shared.APP_LANGUAGE == "ar"{
//            self.nameLabel.text = "\(String(describing: model.itemQty.value ?? 0).enToArDigits)* \(model.itemTitle.value ?? "")"
            
        }else{
//            self.nameLabel.text = "\(String(describing: model.itemQty.value ?? 0))x \(model.itemTitle.value ?? "")"
            
        }
        
        let price = Float(model.itemQty.value ?? 0) * (model.itemPrice.value ?? 0.0)
        
//        self.priceLabel.text = " \(String(format: "%.2f", price ) + "\(String(describing: model.currencyCode.value ?? "" ))")"
//        [self.nameLabel].forEach {
//            $0?.textAlignment = K.shared.APP_LANGUAGE == SupportedLanguage.Arabic.rawValue ? .right : .left
//        }
    }
    
}
