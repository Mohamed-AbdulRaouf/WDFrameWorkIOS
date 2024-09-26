//
//  STKashierUseCase.swift
//  HamamAbdo
//
//  Created by SimpleTouch on 8/26/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
import SwifterSwift

class STKashierUseCase : STKashierService  {
    
    
    init(){}
    public func saveShopperCard(cardData: ICardDTODAL, shopperReference: String,completion: @escaping PaymentCallBack) {
        
    }
    /// This Function to get the List of Cards for Shopper reference
    /// - Parameters:
    ///   - shopperReference: the user Id
    ///   - completion: returns the list of cards
    public func listShopperCards(shopperReference: String, completion: @escaping PaymentCallBack) {
        
    }
    
    public func payWithCard(cardData: ICardDTODAL, orderId: String, amount: String, shopperReference: String, shouldSaveCard: Bool, completion: @escaping PaymentCallBack) {
        
    }
    public func payWithPermToken(shopperReference: String, orderId: String, amount: String, cardToken: String, completion: @escaping PaymentCallBack) {
        
    }
    
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
