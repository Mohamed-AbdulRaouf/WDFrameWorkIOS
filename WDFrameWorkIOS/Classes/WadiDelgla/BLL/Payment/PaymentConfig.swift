//
//  PaymentConfig.swift
//  BLL
//
//  Created by SimpleTouch on 8/5/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

//import Foundation
//import  KashierPaymentSDK
//
///// Edit these parameters to start usign our Example app
//let merchantId : String = "MID-1038-406"
//let apiKey : String = "790b5ab0-8ce0-4466-b102-acf943bdce04"
//var shopperReference :String = ""
/////-------------------------------------
//
//
//let sdkMode : KASHIER_SDK_MODE = .DEVELOPMENT
//var tokenType :KASHIER_TOKEN_VALIDITY = .PERMANENT
//var use3Ds : Bool = false
//var orderId :String = generateRandomString()
//
//var name : String = "kashier testing user";
////use 05/22 to test error response in payment
//var month : String = "05";
//var year  : String = "21";
//
//var cardToken : String = "";
//var ccvToken : String = "";
//var cvv : String = ""
//var numCard : String = ""
//var Amount :String = generateRandomString()
//
//
//var cardData : Card = Card(cardHolderName: name, cardNumber: numCard, cardCcv: cvv, cardExpiryMonth: month , cardExpiryYear: year)
//
//
//func setCardData() -> Void {
//    if (use3Ds) {
//        cvv = "100";
//        numCard = "5123450000000008";
//    } else {
//        cvv = "100";
//        numCard = "5111111111111118";
//        //numCard = "4012000033330026";
//    }
//
//    cardData = Card(
//        cardHolderName: name,
//        cardNumber: numCard,
//        cardCcv: cvv,
//        cardExpiryMonth: month,
//        cardExpiryYear: year);
//}
//func generateRandomString() -> String {return "\(Int.random(in: 1000 ..< 1000000))"}
//
