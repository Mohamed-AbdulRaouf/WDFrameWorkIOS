//
//  UserAddressTableViewCell.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 11/3/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
//import DAL
class UserAddressTableViewCell: UITableViewCell,IBaseTableViewCell {
    typealias T = IUserAddressDTODAL
//    typealias viewModelType = IUserAddressDTO

    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var addressIndexButton: UIButton!
    @IBOutlet weak var apartmentNoLabel: UILabel!
    
    @IBOutlet weak var areaNameLabel: UILabel!
    @IBOutlet weak var floorNoLabel: UILabel!
    @IBOutlet weak var landMarkLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var streetNameLabel: UILabel!
    @IBOutlet weak var buildingNoLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(_ model: IUserAddressDTODAL) {
        
        self.buildingNoLabel.text = "\(R.string.localizable.building_no()) : \(model.buildingNo.value ?? "")"
        self.streetNameLabel.text = "\(R.string.localizable.street_name()) : \(model.streetName.value ?? "")"
        self.companyNameLabel.text = "\(model.companyName.value ?? "")"
        self.landMarkLabel.text = "\(model.addressDescription.value ?? "")"
        
        [buildingNoLabel,streetNameLabel,companyNameLabel,landMarkLabel].forEach { (label) in
            label?.font = APP_FONT_BOLD //UIFont(resource: APP_FONT_BOLD, size: 14)
            label?.textColor = .lightGray
        }
        self.floorNoLabel.text = "\(R.string.localizable.floor_no()) : \(model.floorNo.value ?? "")"
        self.apartmentNoLabel.text = ""
        self.areaNameLabel.text = "\(model.areaName.value ?? "")"
        [floorNoLabel,apartmentNoLabel,areaNameLabel].forEach { (label) in
            label?.font = APP_FONT_BOLD //UIFont(resource: APP_FONT_BOLD, size: 17)
            label?.textColor = .black
        }
        
        [self.addressIndexButton].forEach { (button) in
            button?.backgroundColor = COLOR_ACCENT
            button?.titleLabel?.font = APP_FONT_BOLD //UIFont(resource: APP_FONT_BOLD, size: 17)
            button?.titleLabel?.sizeToFit()
            button?.cornerRadius = 20.0
            button?.setTitleColor(.white, for: .normal)
            button?.setTitle("\(model.addressIndex.value ?? 0)", for: .normal)
            
        }
        
        self.containerView.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
    }
}

