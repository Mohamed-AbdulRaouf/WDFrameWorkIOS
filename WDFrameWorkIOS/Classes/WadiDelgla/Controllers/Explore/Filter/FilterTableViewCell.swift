//
//  FilterTableViewCell.swift
//  STDobites
//
//  Created by SimpleTouch on 11/11/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
//import DAL
class FilterTableViewCell: UITableViewCell,IBaseTableViewCell {
    typealias T = IBaseFilterDTODAL
    
    @IBOutlet weak var filterSwitch: UISwitch!
    @IBOutlet weak var nameLabel: UILabel!
    var onfilterTapped: ((Bool) -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        filterSwitch.semanticContentAttribute = LocalizationSystem.sharedInstance.isCurrentLanguageArabic() ? .forceRightToLeft : .forceLeftToRight
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(_ model: IBaseFilterDTODAL) {
        self.nameLabel.font = APP_FONT_REGULAR //UIFont(resource: APP_FONT_REGULAR, size: 15)
        self.nameLabel.text = model.name.value ?? ""
        self.filterSwitch.isOn = model.isSelected.value ?? false
    }

    @IBAction func onFilterSwitchTapped(_ sender: Any) {
        self.onfilterTapped!(filterSwitch.isOn)
    }
}
// MARK: - UIView Extension -

extension UIView {

    /**
     Rotate a view by specified degrees

     - parameter angle: angle in degrees
     */
    func rotate(angle angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = self.transform.rotated(by: radians);
        self.transform = rotation
    }

}
