//
//  ProductSizeTableViewCell.swift
//  STDobites
//
//  Created by SimpleTouch on 11/17/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
//import DAL
class ProductSizeTableViewCell: UITableViewCell,IBaseTableViewCell {
    typealias T = IMenuSizeDTODAL
    @IBOutlet weak var sizePriceLabel: UILabel!
    @IBOutlet weak var selectSizeBtn: UIButton!
    @IBOutlet weak var sizeNameLabel: UILabel!
    @IBOutlet weak var radioButton: SSRadioButton!
    var onSelectedSize: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(_ model: IMenuSizeDTODAL) {
        self.sizeNameLabel.text = model.sizeName.value ?? ""
        self.sizePriceLabel.text = "\(model.sizePrice.value ?? 0) \(model.currencyCode.value ?? "")"
        [self.sizeNameLabel,self.sizePriceLabel].forEach {
            $0?.font = APP_FONT_BOLD //UIFont(resource: APP_FONT_BOLD, size: 16)
            $0?.textColor = COLOR_PRIMARY_TEXT
        }
        [radioButton].forEach {
            $0?.circleColor = COLOR_ACCENT
            $0?.strokeColor = COLOR_PRIMARY_TEXT
            $0?.circleRadius = 10.0
        }
        self.radioButton.isSelected = model.isSelected.value ?? false
    }
    
    @IBAction func onRadioTapped(_ sender: Any) {
        self.onSelectedSize!()
    }
    
    @IBAction func selectSizeBtnTapped(_ sender: Any) {
        self.onSelectedSize!()
    }
}
