//
//  STEnum.swift
//  STDobites
//
//  Created by SimpleTouch on 9/10/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
//import DAL
class SelectedPaymentMethodDTO {
    var paymentType : PaymentType
    var isSelected : Bool
    init(_ paymentType : PaymentType,_ isSelected: Bool) {
        self.paymentType = paymentType
        self.isSelected = isSelected
    }
}
enum PaymentType : CaseIterable{
    case cashOnDelivery,creditCard
    var orderPaymentId : Int {
        switch self {
        case .cashOnDelivery:
            return 1
        case .creditCard:
            return 2
        }
    }
     var name: String {
        switch self {
        case .cashOnDelivery:
            return "cash_on_delivery".localized()
        case .creditCard:
            return "pay_with_credit_card".localized()
        }
  }
}
enum ContractType {
    case onlineOrder,loyality
    var contractTypeId : Int {
        switch self {
        case .onlineOrder:
            return 1
        case .loyality:
            return 2
        }
    }
}
enum SupportedLanguage : String{
    case Arabic = "ar"
    case English = "en"
}
enum OrderType {
    case online,atStore,dine_in,drive_thrue,delivery
    var instance: IOrderTypeDTODAL {
        switch self {
        case .online: return OrderTypeDTODAL(id: OrderType.online.id, name: OrderType.online.name, image: imageName)
        case .atStore: return OrderTypeDTODAL(id: OrderType.atStore.id, name: OrderType.atStore.name, image: OrderType.atStore.imageName)
        case .dine_in: return OrderTypeDTODAL(id: OrderType.dine_in.id, name: OrderType.dine_in.name, image: OrderType.dine_in.imageName)
        case .drive_thrue: return OrderTypeDTODAL(id: OrderType.drive_thrue.id, name: OrderType.drive_thrue.name, image: OrderType.drive_thrue.imageName)
        case .delivery: return OrderTypeDTODAL(id: OrderType.delivery.id, name: OrderType.delivery.name, image: OrderType.delivery.imageName)
            
        }
    }
    var id : Int {
        switch self {
        case .online:
            return 1
        case .atStore:
            return 2
        case .dine_in:
            return 3
        case .drive_thrue:
            return 4
        case .delivery:
            return 5
        }
    }
    var name : String {
        switch self {
        case .online:
            return "online".localized()
        case .atStore:
            return "atStore".localized()
        case .dine_in:
            return "dine_in".localized()
        case .drive_thrue:
            return "drive_thru".localized()
        case .delivery:
            return "delivery".localized()
        }
    }
    var imageName : String {
        switch self {
        case .online:
            return R.image.ic_at_store.name
        case .atStore:
            return R.image.ic_online.name
        case .dine_in:
            return R.image.ic_dine_in.name
        case .drive_thrue:
            return R.image.ic_drive_thru.name
        case .delivery:
            return R.image.ic_order_delivery.name
        }
    }
}
enum FontAwesome_ImageIcons_Names: String{
    case heart_bold = "fas fa-heart"
    case map_marker_bold = "fas fa-map-marker-alt"
    case info_circle_bold = "fas fa-info-circle"
    case home_bold = "fas fa-home"
    case shopping_basket = "fas fa-shopping-basket"
    case shopping_cart = "fas fa-shopping-cart"
    case barCode = "fas fa-barcode"
    case user_circle = "fas fa-user-circle"
    case bell = "fas fa-bell"
    case globe = "fas fa-globe"
    case signInOut = "fas fa-sign-out-alt"
    case trash = "fas fa-trash"
    case comment_regular = "far fa-comment-alt"
    case star = "fas fa-star"
    case clock_light = "fal fa-clock"
    case circle_light = "fal fa-usd-circle"
}
enum Gender: String{
    case male = "M"
    case female = "F"
    case none = "N"
}
enum NotificationName: String {
    case userNotAllowAccessLocation = "userNotAllowAccessLocation"
    case NOTIFICATION_CART = "cartItemCount"
//    let NOTIFICATION_CART = Notification.Name("cartItemCount")
}
