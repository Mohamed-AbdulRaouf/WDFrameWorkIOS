//
//  SortTableViewCell.swift
//  STDobites
//
//  Created by SimpleTouch on 11/11/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
//import DAL
class SortTableViewCell: UITableViewCell,IBaseTableViewCell {
    typealias T = IServiceDTODAL

    @IBOutlet weak var nameLabel: UILabel!
     
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(_ model: IServiceDTODAL) {
        self.nameLabel.text = model.serviceName.value ?? ""
    }
    

}
