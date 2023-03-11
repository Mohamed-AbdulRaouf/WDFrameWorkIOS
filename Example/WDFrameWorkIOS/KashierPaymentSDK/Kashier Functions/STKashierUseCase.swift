//
//  STKashierUseCase.swift
//  HamamAbdo
//
//  Created by SimpleTouch on 8/26/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
//import KashierPaymentSDK
//import DAL
//import BLL
import SwifterSwift
import WDFrameWorkIOS
 class STKashierUseCase : STKashierService  {
    
    
    init(){}
    public func saveShopperCard(cardData: ICardDTODAL, shopperReference: String,completion: @escaping PaymentCallBack) {
//        let _cardData =  self.getKashierCard(from: cardData)
//
//        //API
//        Kashier.saveShopperCard(cardData: _cardData,
//                                shopperReference: shopperReference,
//                                tokenValidity: .PERMANENT,
//                                tokenizationCallback: TokenizationCallback(
//                                    onResponse: {
//                                        (TokenizationResponse) -> (Void) in
//
//                                        debugPrint("Save Shopper Card Success")
//                                        debugPrint("Card Token: \(TokenizationResponse.cardData?.cardToken ?? "")")
//                                        debugPrint("CVV Token: \(TokenizationResponse.cardData?.ccvToken ?? "NO CCV TOKEN FOR PERM TOKENS")")
//                                        completion(true,nil)
//                                },
//                                    onFailure: {
//                                        (tokenizationError: ErrorData) -> (Void) in
//
//                                        debugPrint("Tokenization failed \(tokenizationError.getErrorMessage())")
//                                        completion(nil,tokenizationError.getErrorMessage())
//
//                                }
//        ))
    }
    /// This Function to get the List of Cards for Shopper reference
    /// - Parameters:
    ///   - shopperReference: the user Id
    ///   - completion: returns the list of cards
    public func listShopperCards(shopperReference: String, completion: @escaping PaymentCallBack) {
//        Kashier.listShopperCards(shopperReference: shopperReference,
//                                 userCallBack: TokensListCallback(
//                                    onResponse: {
//                                        (tokensResponse) -> (Void) in
//                                        debugPrint("Login Tokens List Resposne succ")
//                                        if let _tokens = tokensResponse.response?.tokens {
//                                            for token in _tokens {
//                                                print("Card: \(token.cardNumber ?? "") \(token.cardExpiryMonth ?? "")/\(token.cardExpiryYear ?? "") \(token.token ?? "")")
//                                            }
//                                            completion(_tokens,nil)
//                                        }
//                                 }, onFailure: {
//                                    (tokensListError) -> (Void) in
//                                    debugPrint("Error in tokens list response:  \(tokensListError.getErrorMessage())")
//                                    completion(nil,tokensListError.getErrorMessage())
//                                 }))
    }

    public func payWithCard(cardData: ICardDTODAL, orderId: String, amount: String, shopperReference: String, shouldSaveCard: Bool, completion: @escaping PaymentCallBack) {
//           let _cardData =  getKashierCard(from: cardData)
//        Kashier.payWithCard(cardData: _cardData,
//                                   orderId: orderId,
//                                   amount: amount,
//                                   shopperReference: shopperReference,
//                                   shouldSaveCard: shouldSaveCard,
//                                   paymentCallback: PaymentCallback(onResponse: { (succ) -> (Void) in
//                                       print("Payment with Token Success: \(succ.getResponseMessageTranslated())")
//                                    completion(succ.response,nil)
//
//                                   }) { (error) -> (Void) in
//                                       print("Payment with Token Error: \(error.getErrorMessage())")
//                                    completion(nil,error.getErrorMessage())
//                                   })
    }
    public func payWithPermToken(shopperReference: String, orderId: String, amount: String, cardToken: String, completion: @escaping PaymentCallBack) {
//        Kashier.payWithPermToken(
//                       shopperReference: shopperReference,
//                       orderId: orderId,
//                       amount: amount,
//                       cardToken: cardToken,
//                        paymentCallback: PaymentCallback(onResponse: { (succ) -> (Void) in
//                                                             print("Payment with Token Success: \(succ.getResponseMessageTranslated())")
//                            completion(succ.response,nil)
//
//                                                         }) { (error) -> (Void) in
//                                                             print("Payment with Token Error: \(error.getErrorMessage())")
//                                                            completion(nil,error.getErrorMessage())
//                                                         })
    }
    
//     func getKashierCard(from cardData: ICardDTO) -> Card {
//        return Card(cardHolderName: cardData.cardHolderName.value ?? "", cardNumber: cardData.cardNumber.value ?? "", cardCcv: cardData.cardCvv.value ?? "", cardExpiryMonth:  String((cardData.cardExpiryDate.value ?? "")[0...1]), cardExpiryYear: String((cardData.cardExpiryDate.value ?? "")[2...3]))
//    }
//     func getPaymentData(from paymentResponse : PaymentResponse?,_ orderId: String?,_ status: Bool) -> IConfirmPaymentDTO{
//        if let paymentResponse = paymentResponse,let _ = paymentResponse.transactionID,status {
//             return ConfirmPaymentDTO(transactionId: paymentResponse.transactionID ?? "", merchanOrderId: paymentResponse.merchantOrderID ?? "", orderId: paymentResponse.orderID ?? "", status: true)
//        }
//        if let orderId = orderId,status,paymentResponse?.transactionID == nil  {
//            return ConfirmPaymentDTO(transactionId: "MerchanOrderId-\(orderId)", merchanOrderId: orderId, orderId: "MerchanOrderId-\(orderId)", status: false)
//        }
//        return  ConfirmPaymentDTO(transactionId: "", merchanOrderId: orderId ?? "", orderId: "", status: false)
//    }
}
extension StringProtocol {
    subscript(offset: Int) -> Character { self[index(startIndex, offsetBy: offset)] }
    subscript(range: Range<Int>) -> SubSequence {
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        return self[startIndex..<index(startIndex, offsetBy: range.count)]
    }
    subscript(range: ClosedRange<Int>) -> SubSequence {
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        return self[startIndex..<index(startIndex, offsetBy: range.count)]
    }
    subscript(range: PartialRangeFrom<Int>) -> SubSequence { self[index(startIndex, offsetBy: range.lowerBound)...] }
    subscript(range: PartialRangeThrough<Int>) -> SubSequence { self[...index(startIndex, offsetBy: range.upperBound)] }
    subscript(range: PartialRangeUpTo<Int>) -> SubSequence { self[..<index(startIndex, offsetBy: range.upperBound)] }
}
