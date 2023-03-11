//
//  OrderRoute.swift
//  BLL
//
//  Created by SimpleTouch on 11/21/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Alamofire
////import DAL
enum OrderRouteBLL: URLRequestBuilderBLL {
    
    // order
    case calcOrder(order: ISTCheckoutOrderDTODAL)
    case checkout(order: ISTCheckoutOrderDTODAL)
    case makeOrder(order: ISTCheckoutOrderDTODAL)
    case getOrderRate(customerHistoryId: Int)
    case rateOrder(order: IRateOrderDTODAL)
    case confirmOnLinePaymentForOrder(model: IConfirmPaymentDTODAL)
    case GetOrderByFrontReference(frontOrderReferenceId: String)
    case ConfirmOnLinePaymentForOrderMyFatoorah(model: IConfirmMyFatoorahPaymentDTODAL)
     // MARK: - Path
    internal var path: ServerPathsBLL {
        switch self {
        case .calcOrder:
            return .CALC_ORDER
        case .checkout:
            return .CHECKOUT
        case .makeOrder:
            return .MAKE_ORDER
        case .getOrderRate:
            return .GET_ORDER_RATE
        case .rateOrder:
            return .RATE_ORDER
        case .confirmOnLinePaymentForOrder:
            return .CONFIRM_ONLINE_PAYMENT_FOR_ORDER
        case .GetOrderByFrontReference:
            return .GET_ORDER_BY_FRONT_REFERENCE
        case .ConfirmOnLinePaymentForOrderMyFatoorah:
            return .CONFIRM_ONLINE_PAYMENT_FOR_ORDER_MY_FATOORAH
        }
    }
    
    // MARK: - Parameters
    internal var parameters: Parameters? {
        var params = defaultParams
        switch self {
        case let .calcOrder(order),let .checkout(order),let .makeOrder(order):
            let cart = order.JSONRepresentation
            cart.forEach { (k,v) in params[k] = v }
        case let .rateOrder(order):
            let rateOrder = order.JSONRepresentation
            rateOrder.forEach { (k,v) in params[k] = v }
        case let .confirmOnLinePaymentForOrder(model):
            params[KBLL.APIParameterKey.transactionId] = model.transactionId.value ?? ""
            params[KBLL.APIParameterKey.merchanOrderId] = model.merchanOrderId.value ?? ""
            params[KBLL.APIParameterKey.orderId] = model.merchanOrderId.value ?? ""
            params[KBLL.APIParameterKey.status] = model.status.value ?? false
            params["Language"] = Config.language
            params["CustomerID"] = model.customerID.value ?? 0
        case let .GetOrderByFrontReference(frontOrderReferenceId):
            params[KBLL.APIParameterKey.frontOrderReferenceId] = frontOrderReferenceId
        case let .ConfirmOnLinePaymentForOrderMyFatoorah(model):
            params[KBLL.APIParameterKey.referencePaymentId] = model.referencePaymentId.value ?? ""
            params[KBLL.APIParameterKey.referenceTransactionId] = model.referenceTransactionId.value ?? ""
            params[KBLL.APIParameterKey.referenceInvoiceId] = model.referenceInvoiceId.value ?? ""
            params[KBLL.APIParameterKey.frontOrderReferenceId] = model.frontOrderReferenceId.value ?? ""
            params[KBLL.APIParameterKey.customerHistoryId] = model.customerHistoryId.value ?? 0
            params[KBLL.APIParameterKey.orderId] = model.orderId.value ?? ""
            params[KBLL.APIParameterKey.status] = model.status.value ?? false

        default: break
         }
        
        return params
    }
    internal var headers: HTTPHeaders {
            let default_headers = defaultHeaders
               return default_headers
           }
    internal var urlParameters: [String]? {
        var params = [String]()
        switch self {
        case let .getOrderRate(customerHistoryId):
            params.append(String(customerHistoryId))
            params.append(Config.language)
         default:
            break
        }
        return params
    }
    internal var urlQueryParameters: [[String : String]]?{
        let params =  [[String : String]]()
        switch self {
        default:
            break
        }
        return params
    }
    
    // MARK: - Methods
    internal var method: HTTPMethod {
        switch self {
        case .getOrderRate,.GetOrderByFrontReference:
            return .get
        default:
            return .post
        }
    }
}
