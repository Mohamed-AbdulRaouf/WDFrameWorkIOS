//
//  OrderService.swift
//  BLL
//
//  Created by SimpleTouch on 11/21/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
////import DAL
//MARK:- Order
public protocol OrderServiceBLL :AnyObject {
    func calcOrder(_ order: ISTCheckoutOrderDTODAL,completion: @escaping onSuccessBLL)
    func checkout(_ order: ISTCheckoutOrderDTODAL,completion: @escaping onSuccessBLL)
    func makeOrder(_ order: ISTCheckoutOrderDTODAL,completion: @escaping onSuccessBLL)
    func getRateOrder(_ customerHistoryId: Int,completion: @escaping onSuccessBLL)
    func rateOrder(_ order: IRateOrderDTODAL,completion: @escaping onSuccessBLL)
    func confirmOnLinePaymentForOrder(_ model: IConfirmPaymentDTODAL,completion: @escaping onSuccessBLL)
    func getOrderByFrontReference(_ frontOrderReferenceId: String,completion: @escaping onSuccessBLL)
    func generateFrontOrderReferenceId(forBrandId brandId: Int,withUserId userId: String) -> String
    func confirmOnLinePaymentForOrderMyFatoorah(_ model: IConfirmMyFatoorahPaymentDTODAL,completion: @escaping onSuccessBLL)

}

