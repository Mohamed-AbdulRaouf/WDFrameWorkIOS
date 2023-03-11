//
//  ISTCartViewController.swift
//  STDobites
//
//  Created by SimpleTouch on 11/19/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
//import DAL
protocol ISTCartViewController:ICommonFunc {
    func onReloadTableView()
    func onClearCartTapped()
    func openLogin()
    func openUserAddresses()
    func onShowClearCartAlert()
    func showCommentDialog(_ visualCode: String,_ comment:String)
    func openOrderTypeVC()
    func openCheckoutVC()
}
protocol ICartOperation:class{
    func increamentItem(_ item: ISTCartItemDTODAL)
    func decreamentItem(_ item: ISTCartItemDTODAL)
    func deleteItem(_ item: ISTCartItemDTODAL)
    func updateComment(_ visualCode:String,withComment comment: String)
    func updateOrderComment(_ comment: String)

}
