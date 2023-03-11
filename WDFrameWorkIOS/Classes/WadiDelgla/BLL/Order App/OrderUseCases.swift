//
//  OrderUseCases.swift
//  BLL
//
//  Created by SimpleTouch on 11/21/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Alamofire
import Network
////import DAL

public class  OrderUseCasesBLL : OrderServiceBLL  {
    
    private var network: NetworkingBLL
    /// Dependency Inject Network Object
    ///
    /// - Parameter network: Network that is responsible for Calling API
    public init(network : NetworkingBLL){
        self.network = network
    }
    
    /// This Function validate  , Calculate Order and returns
    ///
    /// - Parameters:
    ///   - order: The order Object to be calculated
    ///   - completion: it returns needed details to complete order or error if order is invalid
    public func calcOrder(_ order: ISTCheckoutOrderDTODAL, completion: @escaping onSuccessBLL) {
        //validate data
        
        let validationDTO = OrderValidationDTOBLL()
        let validation = OrderValidationManagerBLL(errorModel: validationDTO)
        
        guard validation.validate(model: order) else {
            completion(STResponseBLL(data: nil,error: STErrorBLL(validateError: validationDTO, APIError: nil)))
            return
        }
        //API
        let request = OrderRouteBLL.calcOrder(order: order)
        network.sendRequest(request) { (response, error) in
            guard error == nil else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: validationDTO , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                return
            }
            
            if response?.messageCode == 601 {
                guard let json = response?.data else {
                    completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: StandardMessagesBLL.faildParseJson)))
                    return
                }
                let order =  try! CalOrderResponseDTODAL.init(json: json)
                completion(STResponseBLL(data: order, error:nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: validationDTO, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
    
    /// This Function validate , Calculate Order and returns
    ///
    /// - Parameters:
    ///   - order: The order Object to be calculated
    ///   - completion: it returns needed details to complete order or error if order is invalid such as
    ///     coupon's errors ,items in cart changed, invalid min Order to deliver
    public func checkout(_ order: ISTCheckoutOrderDTODAL, completion: @escaping onSuccessBLL) {
        //validate data
        
        let validationDTO = OrderValidationDTOBLL()
        let validation = OrderValidationManagerBLL(errorModel: validationDTO)
        
        guard validation.validate(model: order) else {
            completion(STResponseBLL(data: nil,error: STErrorBLL(validateError: validationDTO, APIError: nil)))
            return
        }
        //API
        let request = OrderRouteBLL.checkout(order: order)
        network.sendRequest(request) { (response, error) in
            guard error == nil else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: validationDTO , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                return
            }
            
            if response?.messageCode == 601 {
                guard let json = response?.data else {
                    completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: StandardMessagesBLL.faildParseJson)))
                    return
                }
                let order =  try! CalOrderResponseDTODAL.init(json: json)
                completion(STResponseBLL(data: order, error:nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: validationDTO, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
    /// This Function Finalize Order
    ///
    /// - Parameters:
    ///   - order: Order Object to be finalized
    ///   - completion: it returns CustomerHistoryID of Order if it is Finalized or Error if happened
    public func makeOrder(_ order: ISTCheckoutOrderDTODAL, completion: @escaping onSuccessBLL) {
        //validate data
        
        let validationDTO = OrderValidationDTOBLL()
        let validation = OrderValidationManagerBLL(errorModel: validationDTO)
        
        guard validation.validate(model: order) else {
            completion(STResponseBLL(data: nil,error: STErrorBLL(validateError: validationDTO, APIError: nil)))
            return
        }
        //API
        let request = OrderRouteBLL.makeOrder(order: order)
        network.sendRequest(request) { (response, error) in
            guard error == nil else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: validationDTO , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                return
            }
            
            if response?.messageCode == 601 {
                guard let json = response?.data else {
                    completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: StandardMessagesBLL.faildParseJson)))
                    return
                }
                var params = [String: Any]()
                params["CustomerHistoryID"] = json["CustomerHistoryID"].int
                params["OrderId"] = json["orderid"].int
                completion(STResponseBLL(data: params, error:nil))
                //                completion(STResponseBLL(data: json["CustomerHistoryID"].int, error:nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: validationDTO, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
    /// This Function to get The Customer rates for Specific Order
    ///
    /// - Parameters:
    ///   - customerHistoryId: Customer History Id of Order
    ///   - completion: it returns Order's Rates Details
    public func getRateOrder(_ customerHistoryId: Int, completion: @escaping onSuccessBLL) {
        //API
        let request = OrderRouteBLL.getOrderRate(customerHistoryId: customerHistoryId)
        network.sendRequest(request) { (response, error) in
            guard error == nil else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                return
            }
            if response?.messageCode == 601 {
                guard let json = response?.data else {
                    completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: StandardMessagesBLL.faildParseJson)))
                    return
                }
                let order =  try! RateOrderDTODAL.init(json: json)
                completion(STResponseBLL(data: order, error:nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
    /// This function Rate Order
    ///
    /// - Parameters:
    ///   - order: Order object to be rated
    ///   - completion: it returns success rated Order or faild to rate order
    public func rateOrder(_ order: IRateOrderDTODAL, completion: @escaping onSuccessBLL) {
        
        //API
        let request = OrderRouteBLL.rateOrder(order: order)
        network.sendRequest(request) { (response, error) in
            guard error == nil else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                return
            }
            if response?.messageCode == 638 {
                completion(STResponseBLL(data: true, error:nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
    public func confirmOnLinePaymentForOrder(_ model: IConfirmPaymentDTODAL, completion: @escaping onSuccessBLL) {
        //API
        let request = OrderRouteBLL.confirmOnLinePaymentForOrder(model: model)
        network.sendRequest(request) { (response, error) in
            guard error == nil else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                return
            }
            if response?.messageCode == 601 {
                completion(STResponseBLL(data: true, error:nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
    public func getOrderByFrontReference(_ frontOrderReferenceId: String, completion: @escaping onSuccessBLL) {
        //API
        let request = OrderRouteBLL.GetOrderByFrontReference(frontOrderReferenceId: frontOrderReferenceId)
        network.sendRequest(request) { (response, error) in
            guard error == nil else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                return
            }
            if response?.messageCode == 601 {
                guard let json = response?.data else {
                    completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: StandardMessagesBLL.faildParseJson)))
                    return
                }
                let order =  try! OrderByFrontRefernceDTODAL.init(json: json)
                completion(STResponseBLL(data: order, error:nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
    public func generateFrontOrderReferenceId(forBrandId brandId: Int,withUserId userId: String) -> String {
        let date = Date()
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let minut = calendar.component(.minute, from: date)
        let second = calendar.component(.second, from: date)
        let miSecond = calendar.component(.nanosecond, from: date)
        //           let randomDigits = Int.random(in: 0..<4)
//        let deviceID = UIDevice.current.identifierForVendor!.uuidString
//        let token = UserDefaults.user?.token.value
        return "I_\(year)_\(month)_\(day)_\(hour)_\(minut)_\(second)_\(miSecond)_\(brandId)_\(userId)"
    }
    public func confirmOnLinePaymentForOrderMyFatoorah(_ model: IConfirmMyFatoorahPaymentDTODAL, completion: @escaping onSuccessBLL) {
        //API
        let request = OrderRouteBLL.ConfirmOnLinePaymentForOrderMyFatoorah(model: model)
        network.sendRequest(request) { (response, error) in
            guard error == nil else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                return
            }
            if response?.messageCode == 601 {
                completion(STResponseBLL(data: true, error:nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
}
