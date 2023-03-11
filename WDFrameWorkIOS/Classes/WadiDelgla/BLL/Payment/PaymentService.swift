//
//  PaymentService.swift
//  BLL
//
//  Created by SimpleTouch on 8/6/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
////import DAL
//MARK:- PaymentService
 
public protocol PaymentServiceBLL :AnyObject {
    
    func validateCardData(cardData: ICardDTODAL,completion: @escaping onSuccessBLL)
//    func saveShopperCard(cardData: ICardDTO, shopperReference: String,completion: @escaping onSuccess)
//    func listShopperCards(shopperReference: String,completion: @escaping onSuccess)
//    func payWithCard(cardData: ICardDTO, orderId: String, amount:String, shopperReference:String, shouldSaveCard: Bool,completion: @escaping onSuccess)
//    func payWithPermToken(shopperReference: String, orderId: String, amount: String, cardToken: String,completion: @escaping onSuccess)
//    func getKashierCard(from cardData: ICardDTO) -> Card
//    func getPaymentData(from paymentResponse : PaymentResponse?,_ orderId: String?,_ status: Bool) -> IConfirmPaymentDTO
    
}

