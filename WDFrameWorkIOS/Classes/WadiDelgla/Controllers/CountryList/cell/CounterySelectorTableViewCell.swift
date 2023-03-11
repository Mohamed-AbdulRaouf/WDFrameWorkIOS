//
//  CounterySelectorTableViewCell.swift
//  STDobites
//
//  Created by SimpleTouch on 11/10/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import UIKit
//import DAL
class CountrySelectorTableViewCell: UITableViewCell {

    
    @IBOutlet weak var countryFlagLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countryCodeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(country: ICountryDTODAL, countryDataType: CountryDataTypeDAL) {
        if let countryCode = country.countryCode.value  {
            self.countryFlagLabel.text = (countryCode).flag()
        }
        self.countryNameLabel.text = country.name.value ?? ""
        if countryDataType == .countryRegionCode {
            self.countryCodeLabel.text = country.countryCode.value ?? ""
        } else if countryDataType == .phoneCode {
            self.countryCodeLabel.text = country.dialCode.value ?? ""
        } else {
            self.countryCodeLabel.text = country.currency.value ?? ""
        }
         
    }
}
