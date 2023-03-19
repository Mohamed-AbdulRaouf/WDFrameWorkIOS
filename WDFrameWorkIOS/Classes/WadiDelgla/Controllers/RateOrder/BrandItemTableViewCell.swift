//
//  BrandItemTableViewCell.swift
//  STDobites
//
//  Created by SimpleTouch on 11/27/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
import Cosmos
//import DAL
class BrandItemTableViewCell: UITableViewCell{
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var brandItemNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }
    var onChangeRateValue: ((Double) -> Void)?

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(_ model: IBrandRatingItemDTODAL,_ isRateBefore: Bool){
        self.brandItemNameLabel.textColor = COLOR_PRIMARY_TEXT
        self.brandItemNameLabel.font = APP_FONT_REGULAR16 //UIFont(resource: , size: 17)
        self.brandItemNameLabel.text = model.brandRatingItemName.value ?? ""
        self.cosmosView.rating = Double(model.value.value ?? 0.0)
        self.cosmosView.isUserInteractionEnabled = !isRateBefore
        // Show only fully filled stars
        cosmosView.settings.fillMode = .half
        // Change the size of the stars
        cosmosView.settings.starSize = 25
        // Set the distance between stars
        cosmosView.settings.starMargin = 0
        // Set the color of a filled star
        cosmosView.settings.filledColor = COLOR_ACCENT
        // Set the border color of an empty star
        cosmosView.settings.emptyBorderColor = COLOR_ACCENT
        // Set the border color of a filled star
        cosmosView.settings.filledBorderColor = COLOR_ACCENT
        
        cosmosView.didFinishTouchingCosmos = { rating in
            self.onChangeRateValue!(rating)
        }
        // A closure that is called when user changes the rating by touching the view.
        // This can be used to update UI as the rating is being changed by moving a finger.
        cosmosView.didTouchCosmos = { rating in
            print(rating)
            self.cosmosView.rating = rating
        }
        
     }
}
