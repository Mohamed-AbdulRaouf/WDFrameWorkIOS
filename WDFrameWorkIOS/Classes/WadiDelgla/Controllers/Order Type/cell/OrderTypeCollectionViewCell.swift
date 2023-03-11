//
//  OrderTypeCollectionViewCell.swift
//  SimpleTouch
//
//  Created by SimpleTouch on 9/28/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import UIKit
//import DAL
import Kingfisher
import SwifterSwift
class OrderTypeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    
    func configureCell(_ model: IOrderTypeDTODAL){
        self.itemNameLabel.text = model.itemTitle.value ?? ""
        self.itemNameLabel.font = UIFont(resource: APP_FONT_REGULAR, size: 14)
        self.itemNameLabel.numberOfLines = 2
        self.itemNameLabel.textColor = COLOR_PRIMARY_TEXT
        if let image = model.itemImage.value {
             self.itemImageView.image = UIImage(named: image)
            self.itemImageView.contentMode = .scaleAspectFit
        }
        self.itemImageView.makeRounded()
        
    }
    
}
