//
//  CreditCardViewModel.swift
//  STDobites
//
//  Created by SimpleTouch on 9/15/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import ReactiveKit
//import DAL
//import BLL
import SVProgressHUD
//import KashierPaymentSDK

protocol IPaymentProtocol:class {
    func didAddNewCard(card: ICardDTODAL,saveCard: Bool)
}
protocol ICreditCardViewModel: IBaseViewModel {
    
    var cardData : ICardDTODAL? {get set}
    var apiClient: PaymentServiceBLL? { get set }
    var kashierService :STKashierService? {get set}
    var errorModel : ICreditCardValidationDTOBLL? {get set}
    var isSaveCard: Bool? {get set}
    func useCard()
    var delegate: ICreditCardViewController? {get set}
    var sourceDelegate: IPaymentProtocol?{get set}
}
class CreditCardViewModel: ICreditCardViewModel{
    weak var delegate: ICreditCardViewController?
    weak var sourceDelegate:IPaymentProtocol?
    var cardData : ICardDTODAL?
    var apiClient: PaymentServiceBLL?
    var kashierService :STKashierService?
    var errorModel : ICreditCardValidationDTOBLL?
    var isSaveCard: Bool?
    public  init (cardData : ICardDTODAL ,apiClient: PaymentServiceBLL,errorModel : ICreditCardValidationDTOBLL,kashierService: STKashierService){
        self.cardData = cardData
        self.errorModel = errorModel
        self.apiClient = apiClient
        self.kashierService = kashierService
        self.isSaveCard = false
    }

    func useCard() {
        self.showHud()
        doInBackground {
            self.apiClient?.validateCardData(cardData: self.cardData!,   completion: { (response) in
                doOnMain {
                    self.hideHUD()
                    guard let _ = response?.data else {
                        self.errorModel = response?.error?.validateError as? ICreditCardValidationDTOBLL
                        self.delegate?.onUpdateLayout()
                        if response?.error?.KashierError != nil {
                            self.delegate?.onError(response?.error?.KashierError?.description ?? "")
                        }
                        return
                    }
                    self.sourceDelegate?.didAddNewCard(card: self.cardData!,saveCard: self.isSaveCard ?? false)
                }
            })
            
        }
    }
    
}
