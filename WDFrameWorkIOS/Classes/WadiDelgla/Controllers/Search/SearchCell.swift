//
//  SearchCell.swift
//  TestSearchBar
//
//  Created by Nermeen Mohamed on 10/23/19.
//  Copyright © 2019 Nermeen Mohamed. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(data: String){
        self.nameLabel.text = data
    }
}
