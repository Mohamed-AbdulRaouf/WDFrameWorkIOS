//
//  CheckoutPaymentTableViewCell.swift
//  HamamAbdo
//
//  Created by SimpleTouch on 8/10/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import UIKit

class CheckoutPaymentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var radioButton: SSRadioButton!
    
    @IBOutlet weak var subTitleLabel: UILabel!
    
    var onSelectedPaymentMethod: (() -> Void)?
    var onSelectChangeCreditCard:(() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        radioButton.setTitleColor(.clear, for: .normal)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configureCell(_ model: SelectedPaymentMethodDTO,_ subTitle: String = "") {
        self.nameLabel.text = model.paymentType.name
        self.nameLabel.font = APP_FONT_REGULAR12 //UIFont(resource: APP_FONT_REGULAR, size: 12)
        self.nameLabel.textColor = COLOR_PRIMARY_TEXT
        [radioButton].forEach {
            $0?.circleColor = COLOR_ACCENT
            $0?.strokeColor = COLOR_PRIMARY_TEXT
            $0?.circleRadius = 10.0
        }
        self.radioButton.isSelected = model.isSelected
        
        self.changeButton.setTitle("change".localized(), for: .normal)
        self.changeButton.setTitleColor(UIColor.init(hexString: "#0DA946"), for: .normal)
        self.changeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        
        self.subTitleLabel.text = subTitle
        self.subTitleLabel.font = APP_FONT_REGULAR10 //UIFont(resource: APP_FONT_REGULAR, size: 10)
        self.subTitleLabel.textColor = COLOR_SUB_TITLE_TEXT
        self.subTitleLabel.isHidden = model.paymentType == PaymentType.cashOnDelivery

        
    }
    @IBAction func onRadioTapped(_ sender: Any) {
        self.onSelectedPaymentMethod!()
    }
    @IBAction func onChangeCreditCardButtonTapped(_ sender: Any) {
        self.onSelectChangeCreditCard!()
    }
    
    @IBAction func selectPaymentBtnTapped(_ sender: Any) {
        self.onSelectedPaymentMethod!()
    }
}
