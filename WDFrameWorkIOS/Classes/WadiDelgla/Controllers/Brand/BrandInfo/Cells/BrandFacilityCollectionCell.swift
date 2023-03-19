//
//  BrandFacilityCollectionCell.swift
//  DoBites
//
//  Created by SimpleTouch on 8/22/19.
//  Copyright © 2019 Nermeen Mohdamed.. All rights reserved.
//

import UIKit
//import DAL
class BrandFacilityCollectionCell: UICollectionViewCell {
    @IBOutlet weak var facilityImageView: UIImageView!
    @IBOutlet weak var facilityNameLabel: UILabel!
    
    func configureCell(_ facility : IFacilityDTODAL){
        self.facilityNameLabel.text = facility.name.value
        self.facilityNameLabel.textColor = COLOR_PRIMARY_TEXT
        self.facilityNameLabel.font = APP_FONT_REGULAR12 // UIFont(resource: APP_FONT_REGULAR, size: 12)
        self.facilityNameLabel.sizeToFit()
        
        
        self.facilityImageView.image =  UIImage.getFontAwaseomImage(fontName: facility.facilityIcon.value ?? "", imageSize: CGSize(width: 40, height: 40))

    }
   
}

