//
//  MoreTableViewCell.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 10/31/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
//import DAL
class MoreTableViewCell: UITableViewCell ,IBaseTableViewCell{
    typealias T = MoreItemDTODAL
    

    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(_ model:MoreItemDTODAL){
        self.itemNameLabel.font = APP_FONT_REGULAR16 //UIFont(resource: APP_FONT_REGULAR, size: 17)
        self.itemNameLabel.textColor = COLOR_PRIMARY_TEXT
        self.itemNameLabel.text = model.itemName
        self.itemImageView.image = UIImage(named: model.itemImageName)
    }

}
