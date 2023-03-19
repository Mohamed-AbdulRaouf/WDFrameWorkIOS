//
//  ProductChoiceTableViewCell.swift
//  STDobites
//
//  Created by SimpleTouch on 11/17/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
//import DAL
class ProductChoiceTableViewCell: UITableViewCell,IBaseTableViewCell {
   

    typealias T = IChoiceDTODAL
    @IBOutlet weak var choicePriceLabel: UILabel!
    @IBOutlet weak var choiceNameLabel: UILabel!
    @IBOutlet weak var checkedButton: UIButton!
    
    var checkedImage = R.image.ic_checked()
    var unCheckedImage = R.image.ic_unchecked()
    
    var isOn: Bool = false {
        didSet {
            checkedButton.setBackgroundImage(self.isOn ? checkedImage : unCheckedImage, for: .normal)
        }
    }
    
    var checkTapAction : ((Bool)->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell(_ model: IChoiceDTODAL) {
         self.choiceNameLabel.text = model.choiceName.value ?? ""
        self.choicePriceLabel.text = "\(model.choicePrice.value ?? 0.0) \(model.currencyCode.value ?? "")"
        [self.choicePriceLabel,self.choiceNameLabel].forEach {
            $0?.font = APP_FONT_BOLD //UIFont(resource: APP_FONT_BOLD, size: 16)
            $0?.textColor = COLOR_PRIMARY_TEXT
        }
        self.isOn = model.isSelectedChoice.value ?? false
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onCheckedTapped(_ sender: Any) {
        self.isOn = !self.isOn
        checkTapAction?(self.isOn)
    }
    
}
