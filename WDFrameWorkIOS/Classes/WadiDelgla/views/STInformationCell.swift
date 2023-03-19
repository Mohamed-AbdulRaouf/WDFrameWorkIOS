//
//  STInformationCell.swift
//  HamamAbdo
//
//  Created by SimpleTouch on 8/4/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import UIKit

class STInformationCell: UITableViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subTitleLabel: UILabel!
    
    func configureCell(_ model : STReusableDTO){
        self.itemImageView.image = model.image
        self.titleLabel.text = model.title
        self.titleLabel.font = APP_FONT_BOLD //UIFont(resource: APP_FONT_BOLD, size: 30)
        self.titleLabel.textColor = COLOR_PRIMARY_TEXT
        self.subTitleLabel.textColor = COLOR_PRIMARY_TEXT
        self.subTitleLabel.font = APP_FONT_REGULAR16 //UIFont(resource: APP_FONT_REGULAR, size: 16)
        self.subTitleLabel.text = model.subTitle
    }
}
