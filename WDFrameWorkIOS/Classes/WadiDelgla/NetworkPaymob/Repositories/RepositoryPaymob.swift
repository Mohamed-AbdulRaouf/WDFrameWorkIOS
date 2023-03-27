//
//  AuthRepositoryDelegate.swift
//  ProjectMVC
//
//  Created by Mohamed Abdul-Raouf on 05/01/2022.
//

import Foundation
import Alamofire

protocol AuthRepositoryDelegate: AnyObject {
    func authenticationRequest(completionHandler: @escaping(AFResultPaymob<AuthenticationRequestModel>) -> Void)
    func orderRegistration(amount: Double,
                           completionHandler: @escaping(AFResultPaymob<OrderRegistrationModel>) -> Void)
    func paymentKeyRequest(amount: Double,
                           completionHandler: @escaping(AFResultPaymob<PaymentKeyRequestModel>) -> Void)
    
    
}

class RepositoryPaymob: AuthRepositoryDelegate {
    private var network: NetworkProtocolPaymob
    init(network: NetworkProtocolPaymob) {
        self.network = network
    }

    func authenticationRequest(completionHandler: @escaping (AFResultPaymob<AuthenticationRequestModel>) -> Void) {
        let route = MainRouterPaymob.authenticationRequest
        network.request(route, decodeTo: AuthenticationRequestModel.self, completionHandler: completionHandler)
    }
    
    func orderRegistration(amount: Double,
                           completionHandler: @escaping(AFResultPaymob<OrderRegistrationModel>) -> Void) {
        let route = MainRouterPaymob.orderRegistration(amount: amount)
        network.request(route, decodeTo: OrderRegistrationModel.self, completionHandler: completionHandler)
    }
    
    func paymentKeyRequest(amount: Double,
                           completionHandler: @escaping(AFResultPaymob<PaymentKeyRequestModel>) -> Void) {
        let route = MainRouterPaymob.paymentKeyRequest(amount: amount)
        network.request(route, decodeTo: PaymentKeyRequestModel.self, completionHandler: completionHandler)
    }
    
}
