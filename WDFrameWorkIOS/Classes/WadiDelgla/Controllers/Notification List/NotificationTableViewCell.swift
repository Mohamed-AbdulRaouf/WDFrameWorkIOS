//
//  NotificationTableViewCell.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 11/2/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
//import DAL
import Kingfisher
class NotificationTableViewCell: UITableViewCell,IBaseTableViewCell {
    
    typealias T = INotificationDTODAL

    @IBOutlet weak var notificationDescriptionLabel: UILabel!
    @IBOutlet weak var readStatusView: UIView!
    @IBOutlet weak var notificationDateLabel: UILabel!
    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var brandLogoImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(_ model: INotificationDTODAL) {
        if let imageUrl = URL(string: model.brandLogoPath.value ?? "") {
            let notificationResource = ImageResource(downloadURL: imageUrl, cacheKey: model.brandLogoPath.value)
            brandLogoImageView.kf.setImage(with: notificationResource)
        } else {
            let imge = R.image.logo()
            brandLogoImageView.image = imge
        }
        brandLogoImageView.clipsToBounds = true
        readStatusView.isHidden = model.isReaded.value ?? false
        readStatusView.backgroundColor = COLOR_ACCENT
        readStatusView.layer.cornerRadius = 10
        model.brandName.bind(to: self.brandNameLabel.reactive.text)
        
        self.notificationDescriptionLabel.text = model.notificationDescription.value
        self.notificationDateLabel.text = model.notificationDate.value
        
        [self.notificationDateLabel].forEach { (label) in
            label?.textColor =  COLOR_PRIMARY_TEXT
            label?.font = APP_FONT_REGULAR12 //UIFont(resource: APP_FONT_REGULAR, size: 12)
        }
        [self.brandNameLabel].forEach { (label) in
            label?.textColor = COLOR_PRIMARY_TEXT
            label?.font = APP_FONT_BOLD //UIFont(resource: APP_FONT_BOLD ,size: 13)
        }
        
        [self.notificationDescriptionLabel].forEach { (label) in
            label?.textColor = COLOR_PRIMARY_TEXT
            label?.font = APP_FONT_REGULAR //UIFont(resource: APP_FONT_REGULAR ,size: 12)
        }
    }

}
