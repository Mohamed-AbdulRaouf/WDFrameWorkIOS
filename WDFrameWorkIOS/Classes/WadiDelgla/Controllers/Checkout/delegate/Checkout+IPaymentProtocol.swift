//
//  Checkout+IPaymentProtocol.swift
//  HamamAbdo
//
//  Created by SimpleTouch on 8/11/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import UIKit
//import KashierPaymentSDK
//import DAL
extension CheckOutViewController : IPaymentProtocol {
    
   func didAddNewCard(card: ICardDTODAL,saveCard: Bool) {
        print(card.cardNumber)
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: CheckOutViewController.self) {
                self.navigationController!.popToViewController(controller, animated: false)
                break
            }
        }
        self.viewModel?.paymentData = STCartPaymentDTODAL(card as? CardDTODAL, nil)
        self.viewModel?.paymentData?.cardData = card as? CardDTODAL
        self.viewModel?.isSaveCard = saveCard
        self.onReloadTableView()
    }
    
}
