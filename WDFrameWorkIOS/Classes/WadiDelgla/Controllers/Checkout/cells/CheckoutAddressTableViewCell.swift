//
//  CheckoutAddressTableViewCell.swift
//  STDobites
//
//  Created by SimpleTouch on 11/25/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit

class CheckoutAddressTableViewCell: UITableViewCell {
    
    @IBOutlet weak var changeAddressButton: UIButton!
    @IBOutlet weak var addressLabel: UILabel!
    var onChangeAddressTapped : (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configureCell(_ address : String){
        self.addressLabel.text = address
        self.addressLabel.textColor = COLOR_SUB_TITLE_TEXT
        self.addressLabel.font = UIFont(resource: APP_FONT_REGULAR, size: 14)
        self.changeAddressButton.setTitle(R.string.localizable.change(), for: .normal)
        self.changeAddressButton.setTitleColor(UIColor.init(hexString: "#0DA946"), for: .normal)
        self.changeAddressButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        self.changeAddressButton.addTarget(self, action: #selector(onButtonTapped(_:)), for: .touchUpInside)
    }
    @IBAction func onButtonTapped(_ sender : Any){
        self.onChangeAddressTapped!()
    }
    
    
}
