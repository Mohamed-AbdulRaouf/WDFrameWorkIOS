//
//  OrderTableViewCell.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 10/31/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
import Cosmos
//import DAL
import Kingfisher
import SwifterSwift
import Bond
class OrderTableViewCell: UITableViewCell,IBaseTableViewCell {
    typealias T = IOrderDTODAL
    @IBOutlet weak var brandLogoImageView: UIImageView!
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var orderStatusLabel: UILabel!
    @IBOutlet weak var orderRefLabel: UILabel!
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var orderDateLabel: UILabel!
    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var rateButton: UIButton!
    
    var onRateTapped: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(_ model: IOrderDTODAL) {
        self.accessoryView = UIImageView(image: R.image.accessoryRed())
        if LocalizationSystem.sharedInstance.isCurrentLanguageArabic() {
            self.accessoryView?.transform = CGAffineTransform(rotationAngle: .pi)
        }
        model.brandName.bind(to: self.brandNameLabel.reactive.text)
        model.orderDate.bind(to: self.orderDateLabel.reactive.text)
        self.orderNumberLabel.text = "\("order_number".localized()): \(model.orderNumber.value ?? 0) - \("total".localized()): \(model.orderTotal.value ?? 0.0) \(model.currencyCode.value ?? "")"
        self.orderRefLabel.text = "\("order_ref".localized()): \(model.customerHistoryId.value ?? 0)"
        
        
        if let imageUrl = URL(string: model.brandLogoURL.value ?? ""){
            let resource = ImageResource(downloadURL: imageUrl, cacheKey: model.brandLogoURL.value)
            self.brandLogoImageView.kf.setImage(with: resource)
        } else {
            self.brandLogoImageView.image = UIImage(named: "dobites_splash")
        }
        let title = model.isOrderRatedBefore.value ?? false ? "show_rate".localized() : "rate_order".localized()
        self.rateButton.setTitle(title, for: .normal)
        self.accessoryType = !(model.isOrderHasDetails.value ?? false) ? .none : .disclosureIndicator
        self.rateView.rating = Double(model.rating.value ?? 0.0)
        self.rateView.isUserInteractionEnabled = false
        self.orderDateLabel.text = Date.convertDate("yyyy-MM-dd'T'HH:mm:ss", model.orderDate.value ?? "", "dd MMMM yyyy - hh:mm")
        self.rateView.isHidden = !(model.isOrderStatusValidToRate.value ?? true)
        self.rateButton.isHidden = !(model.isOrderStatusValidToRate.value ?? true)
        [brandNameLabel].forEach { (label) in
            label?.font = APP_FONT_BOLD14 //UIFont(resource: APP_FONT_BOLD, size: 18)
            label?.textColor = COLOR_PRIMARY_TEXT
        }
        
        [orderDateLabel,orderNumberLabel,orderRefLabel].forEach { (label) in
            label?.font = APP_FONT_REGULAR12 //UIFont(resource: APP_FONT_REGULAR, size: 12)
            label?.textColor = COLOR_PRIMARY_TEXT
        }
       
        self.orderStatusLabel.attributedText = setupLabels("\("order_status".localized()) : ", "\(model.orderStatus.value ?? "")", UIColor.init(hexString: String(model.colorCode.value?.dropFirst() ?? "")) ?? COLOR_PRIMARY_TEXT)
        self.orderStatusLabel.font = APP_FONT_REGULAR10
        
        if let ishasdetails = model.isOrderHasDetails.value ,!ishasdetails{
            self.accessoryView = .none
            self.accessoryType = .none
        }
    }
    func setupLabels(_ str1:String,_ str2:String ,_ strColor  : UIColor) -> NSMutableAttributedString {
//        let attrs1 = [NSAttributedString.Key.font : UIFont(resource: APP_FONT_REGULAR, size: 12), NSAttributedString.Key.foregroundColor : COLOR_PRIMARY_TEXT]
        let attrs1 = [NSAttributedString.Key.font : APP_FONT_REGULAR10, NSAttributedString.Key.foregroundColor : COLOR_PRIMARY_TEXT]
        
//        let attrs2 = [NSAttributedString.Key.font : UIFont(resource: APP_FONT_BOLD, size: 13), NSAttributedString.Key.foregroundColor : strColor]
        let attrs2 = [NSAttributedString.Key.font : APP_FONT_REGULAR10, NSAttributedString.Key.foregroundColor : strColor]
        
        let attributedString1 = NSMutableAttributedString(string:str1, attributes:attrs1)
        
        let attributedString2 = NSMutableAttributedString(string: str2, attributes:attrs2)
        
        attributedString1.append(attributedString2)
        return attributedString1
    }
    @IBAction func onRateTapped(_ sender: Any) {
        self.onRateTapped!()
    }
    
    func getRequiredFormat(dateStrInTwentyFourHourFomat: String) -> String? {

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        if let newDate = dateFormatter.date(from: dateStrInTwentyFourHourFomat) {

            let timeFormat = DateFormatter()
            timeFormat.timeZone = TimeZone.autoupdatingCurrent
            timeFormat.locale = Locale(identifier: "en_US_POSIX")
            timeFormat.dateFormat = "hh:mm a"

            let requiredStr = timeFormat.string(from: newDate)
            return requiredStr
        } else {
            return nil
        }
    }
}
