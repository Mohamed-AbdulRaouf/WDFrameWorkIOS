//
//  BrandHeaderInfoTableViewCellViewModel.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 11/5/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import Kingfisher
//import DAL
protocol IBrandHeaderInfoTableViewCellViewModel: IBaseViewModel {
     var shareImage : UIImage! { get set }
    var directionImage: UIImage! {get set}
    var brandImageResource : Any! {get set}
    var brandLogoResource: Any! {get set}
    var cuisine : String! {get set}
    var rating: Double! {get set}
    var ratingText: String! {get set}
    var isHiddedShareButton : Bool! {get set}
    var brandName : String! {get set}
    var isUserCanRate: Bool! {get set}
    func viewDidLoad(_ model: IBrandDTODAL)
}
class BrandHeaderInfoTableViewCellViewModel: IBrandHeaderInfoTableViewCellViewModel{
    var shareImage: UIImage!
    var directionImage: UIImage!
    var brandImageResource: Any!
    var brandLogoResource: Any!
    var cuisine : String!
    var rating: Double!
    var ratingText: String!
    var isHiddedShareButton: Bool! = false
    var brandName: String!
    var isUserCanRate: Bool! = false
    init() {}
    func viewDidLoad(_ model: IBrandDTODAL) {
        let iconImage:UIImage? = UIImage.getFontAwaseomImage(fontName: "fas fa-share-alt",imageSize: CGSize(width: 30, height: 30))
        self.shareImage = iconImage
        let dircection_iconImage:UIImage? = UIImage.getFontAwaseomImage(fontName: "fas fa-map-marker-alt",imageSize: CGSize(width: 25, height: 25))
        self.directionImage = dircection_iconImage

        if let brandImageUrl = URL(string: model.backgroundAdsImage.value ?? "") {
            let resource = ImageResource(downloadURL: brandImageUrl, cacheKey: model.backgroundAdsImage.value ?? "")
            self.brandImageResource = resource
        }else{
            brandImageResource = R.image.ic_dobites()
        }
        
        if let brandImageUrl = URL(string: model.brandLogoPath.value ?? "") {
            let resource = ImageResource(downloadURL: brandImageUrl, cacheKey: model.brandLogoPath.value ?? "")
           self.brandLogoResource = resource
        } else {
            self.brandLogoResource = R.image.ic_dobites()
        }
        var cuisine = ""
        model.cuisines.value?.forEach({ (item) in
            cuisine += item.name.value ?? ""
        })
        self.cuisine = cuisine
        self.rating =  Double(model.ratingValue.value ?? 0)
        self.ratingText = "(\(model.numberOfUserRate.value ?? 0))"
        self.brandName = model.brandName.value ?? ""
        self.isUserCanRate = false
        
        
        if  let shareCode = model.shareCode.value, let isCanshare =  model.isCanShareToOthers.value {
            
             if UserDefaults.user?.token.value == nil || UserDefaults.user?.token.value == "" || shareCode == "" || !isCanshare {
                self.isHiddedShareButton = true
            }
        }
        
    }
    
    
}
