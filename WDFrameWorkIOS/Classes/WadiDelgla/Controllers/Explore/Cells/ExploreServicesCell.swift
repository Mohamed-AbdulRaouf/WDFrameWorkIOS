//
//  ExploreServicesCell.swift
//  DoBites
//
//  Created by SimpleTouch on 8/26/19.
//  Copyright © 2019 Nermeen Mohdamed.. All rights reserved.
//

import UIKit
//import DAL
class ExploreServicesCell: UICollectionViewCell,IBaseCollectionCell {
    typealias T = IServiceDTODAL
    
    @IBOutlet weak var serviceNameLabel: UILabel!
    @IBOutlet weak var serviceImageView: UIImageView!
    
    func configureCell(_ model: IServiceDTODAL) {
        self.backgroundColor = .clear
        self.serviceImageView.image =  UIImage.getFontAwaseomImage(fontName: model.serviceIcon.value ?? "", imageSize: CGSize(width: 40, height: 40))
        
        self.serviceImageView.image = self.serviceImageView.image?.withRenderingMode(.alwaysTemplate)
        self.serviceImageView.tintColor = UIColor(white: 1, alpha: 0.7)
        
        self.serviceNameLabel.text = model.serviceName.value ?? ""
        self.serviceNameLabel.textColor =  UIColor(white:0, alpha: 0.7)
        self.serviceNameLabel.font = UIFont(resource: APP_FONT_REGULAR, size: 12)
        self.serviceNameLabel.sizeToFit()
        self.serviceNameLabel.textAlignment = .center
    }
     
}
