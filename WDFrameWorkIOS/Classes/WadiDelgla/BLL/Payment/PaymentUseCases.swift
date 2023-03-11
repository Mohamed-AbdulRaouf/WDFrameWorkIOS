//
//  PaymentUseCases.swift
//  BLL
//
//  Created by SimpleTouch on 8/6/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation

////import DAL

public class PaymentUseCasesBLL : PaymentServiceBLL  {
    
    
    public init(){}
    public func validateCardData(cardData: ICardDTODAL,completion: @escaping onSuccessBLL) {
        //validate data
        let validationDTO = CreditCardValidationDTOBLL()
        let validation = CreditCardValidationManagerBLL(errorModel: validationDTO)
        
        guard validation.validate(model: cardData) else {
            completion(STResponseBLL(data: nil,error: STErrorBLL(validateError: validationDTO, APIError: nil)))
            return
        }
         completion(STResponseBLL(data: true, error: nil))
    }
    /*
    public func saveShopperCard(cardData: ICardDTO, shopperReference: String,completion: @escaping onSuccess) {
        //validate data
        let validationDTO = CreditCardValidationDTO()
        let validation = CreditCardValidationManager(errorModel: validationDTO)
        guard validation.validate(model: cardData) else {
            completion(STResponseBLL(data: nil,error: STErrorBLL(validateError: validationDTO, APIError: nil)))
            return
        }
        let _cardData =  getKashierCard(from: cardData)
        //API
        Kashier.saveShopperCard(cardData: _cardData,
                                shopperReference: shopperReference,
                                tokenValidity: .PERMANENT,
                                tokenizationCallback: TokenizationCallback(
                                    onResponse: {
                                        (TokenizationResponse) -> (Void) in
                                        
                                        debugPrint("Save Shopper Card Success")
                                        debugPrint("Card Token: \(TokenizationResponse.cardData?.cardToken ?? "")")
                                        debugPrint("CVV Token: \(TokenizationResponse.cardData?.ccvToken ?? "NO CCV TOKEN FOR PERM TOKENS")")
                                        cardToken = TokenizationResponse.cardData?.cardToken ?? ""
                                        ccvToken = TokenizationResponse.cardData?.ccvToken ?? ""
                                        completion(STResponseBLL(data: true, error: nil))
                                },
                                    onFailure: {
                                        (tokenizationError: ErrorData) -> (Void) in
                                        
                                        debugPrint("Tokenization failed \(tokenizationError.getErrorMessage())")
                                        
                                        completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: validationDTO, APIError: nil,ErrorCode: nil,KashierError:tokenizationError.getErrorMessage())))
                                        
                                }
        ))
    }
    /// This Function to get the List of Cards for Shopper reference
    /// - Parameters:
    ///   - shopperReference: the user Id
    ///   - completion: returns the list of cards
    public func listShopperCards(shopperReference: String, completion: @escaping onSuccess) {
        Kashier.listShopperCards(shopperReference: shopperReference,
                                 userCallBack: TokensListCallback(
                                    onResponse: {
                                        (tokensResponse) -> (Void) in
                                        debugPrint("Login Tokens List Resposne succ")
                                        if let _tokens = tokensResponse.response?.tokens {
                                            for token in _tokens {
                                                print("Card: \(token.cardNumber ?? "") \(token.cardExpiryMonth ?? "")/\(token.cardExpiryYear ?? "") \(token.token ?? "")")
                                            }
                                            completion(STResponseBLL(data: _tokens, error: nil))
                                            
                                        }
                                 }, onFailure: {
                                    (tokensListError) -> (Void) in
                                    debugPrint("Error in tokens list response:  \(tokensListError.getErrorMessage())")
                                    completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: nil,ErrorCode: nil,KashierError:tokensListError.errorMessage)))
                                    
                                 }))
    }

    public func payWithCard(cardData: ICardDTO, orderId: String, amount: String, shopperReference: String, shouldSaveCard: Bool, completion: @escaping onSuccess) {
           let _cardData =  getKashierCard(from: cardData)
        Kashier.payWithCard(cardData: _cardData,
                                   orderId: orderId,
                                   amount: amount,
                                   shopperReference: shopperReference,
                                   shouldSaveCard: shouldSaveCard,
                                   paymentCallback: PaymentCallback(onResponse: { (succ) -> (Void) in
                                       print("Payment with Token Success: \(succ.getResponseMessageTranslated())")
                
                                    completion(STResponseBLL(data: succ.response, error: nil))
                                    
                                   }) { (error) -> (Void) in
                                       print("Payment with Token Error: \(error.getErrorMessage())")
                                      completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: nil,ErrorCode: nil,KashierError:error.getErrorMessage())))
                                   })
    }
    public func payWithPermToken(shopperReference: String, orderId: String, amount: String, cardToken: String, completion: @escaping onSuccess) {
        Kashier.payWithPermToken(
                       shopperReference: shopperReference,
                       orderId: orderId,
                       amount: amount,
                       cardToken: cardToken,
                        paymentCallback: PaymentCallback(onResponse: { (succ) -> (Void) in
                                                             print("Payment with Token Success: \(succ.getResponseMessageTranslated())")
                            
                            completion(STResponseBLL(data: succ.response, error: nil))
                                                          
                                                         }) { (error) -> (Void) in
                                                             print("Payment with Token Error: \(error.getErrorMessage())")
                                                            completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: nil,ErrorCode: nil,KashierError:error.getErrorMessage())))
                                                         })
    }
    
    public func getKashierCard(from cardData: ICardDTO) -> Card {
        return Card(cardHolderName: cardData.cardHolderName.value ?? "", cardNumber: cardData.cardNumber.value ?? "", cardCcv: cardData.cardCvv.value ?? "", cardExpiryMonth:  String((cardData.cardExpiryDate.value ?? "")[0...1]), cardExpiryYear: String((cardData.cardExpiryDate.value ?? "")[2...3]))
    }

    public func getPaymentData(from paymentResponse : PaymentResponse?,_ orderId: String?,_ status: Bool) -> IConfirmPaymentDTO{
        if let paymentResponse = paymentResponse,let _ = paymentResponse.transactionID,status {
             return ConfirmPaymentDTO(transactionId: paymentResponse.transactionID ?? "", merchanOrderId: paymentResponse.merchantOrderID ?? "", orderId: paymentResponse.orderID ?? "", status: true)
        }
        if let orderId = orderId,status,paymentResponse?.transactionID == nil  {
            return ConfirmPaymentDTO(transactionId: "MerchanOrderId-\(orderId)", merchanOrderId: orderId, orderId: "MerchanOrderId-\(orderId)", status: false)
        }
        return  ConfirmPaymentDTO(transactionId: "", merchanOrderId: orderId ?? "", orderId: "", status: false)       
    }
 */
}

