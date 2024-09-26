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
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configureCell(_ model: IOrderItemDTODAL) {
        let price = Float(model.itemQty.value ?? 0) * (model.itemPrice.value ?? 0.0)
    }
    
}
