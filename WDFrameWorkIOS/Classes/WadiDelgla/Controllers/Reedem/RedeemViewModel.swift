//
//  IRedeemViewModel.swift
//  STDobites
//
//  Created by SimpleTouch on 11/25/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import ReactiveKit
//import DAL
//import BLL
import SVProgressHUD
import Kingfisher
import UIKit
protocol IRedeemViewModel: IBaseViewModel {
    var delegate: IRedeemViewController? {get set}
    var order: ICalOrderResponseDTODAL? {get set}
    func calculateRedeemAmount(_ redeemPoints: String) -> String
     func applyRedeem(_ redeemPoint: String?,onComplete:@escaping ((Bool,Int)->Void))
}
class RedeemViewModel: IRedeemViewModel{
    weak var delegate: IRedeemViewController?
    var order: ICalOrderResponseDTODAL?
    public init(){}
    
    func calculateRedeemAmount(_ redeemPoints: String = "0") -> String {
        guard let order = self.order else { return "" }
        let points = Float(order.currentCustomerPointsInBrand.value ?? 0)
        let equivelant = Float(order.equivalentPointsAmount.value ?? 0.0)
        let enterendPoints = Float(redeemPoints) ?? 0
        if points == 0 && equivelant == 0 && enterendPoints == 0 {
            return "0.0 \(order.currencyCode.value ?? "")"
        }
        let result = (enterendPoints / points) * equivelant;
        var formatted = String(format: "%.2f", result)
        formatted = formatted + "\(order.currencyCode.value ?? "")"
        return formatted
    }
    func applyRedeem(_ redeemPoint: String?,onComplete:@escaping ((Bool,Int)->Void)){
        guard let cart = self.order else { return }
        guard let redeemPointAmount = redeemPoint , redeemPoint != ""  else {
            self.order?.redeemPoint.value = 0
            onComplete(true,0)
            return
        }
        
        let redeemValue = Int(redeemPointAmount.arToEnDigits)!
        if redeemValue <= Int((cart.currentCustomerPointsInBrand.value ?? 0)) && redeemValue >= Int(cart.minRedeemAmount.value ?? 0.0) && redeemValue <= Int(cart.maxRedeemAmount.value ?? 0.0) {
            cart.redeemPoint.value = redeemValue
            onComplete(true,redeemValue)
            
        } else if redeemValue < Int(cart.minRedeemAmount.value ?? 0.0) {
            self.delegate?.onShowToast(R.string.localizable.small_min_redeem_msg())
            
        } else if redeemValue > Int(cart.maxRedeemAmount.value ?? 0.0) {
            self.delegate?.onShowToast(R.string.localizable.big_min_redeem_msg())
        } else {
            self.delegate?.onShowToast(R.string.localizable.redeem_points_greater_than_your_points())
        }
    }
}
