//
//  RealmCartService.swift
//  BLL
//
//  Created by SimpleTouch on 11/17/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
////import DAL
//MARK:- Cart
public protocol CartServiceBLL :AnyObject {
    func getCart() -> STCheckoutOrderDTODAL?
    func AddItemToCart(_ itemDTO:IMenuItemsDTODAL,for brand: IBrandDTODAL,areaId: Int,completion: @escaping onSuccessBLL)
    func deleteCart(completion: @escaping ((Bool) -> Void))
    func checkIfSameCurrentCart(_ brandId: Int) -> Bool
    func isItemInCart(cart: STCheckoutOrderDTODAL,chosenItem: STCartItemDTODAL) -> Bool
    func setCart(_ cart: STCheckoutOrderDTODAL,completion: @escaping ((Bool) -> Void))
    func increamentItem(_ item: ISTCartItemDTODAL,completion: @escaping ((Bool) -> Void))
    func decreamentItem(_ item: ISTCartItemDTODAL,completion: @escaping ((Bool) -> Void))
    func deleteItemFromCart(_ item: ISTCartItemDTODAL,completion: @escaping ((Bool) -> Void))
    func updateItemComment(_ visualCode: String,_ comment: String,completion: @escaping ((Bool) -> Void))
    func updateOrderComment(_ comment: String,completion: @escaping ((Bool) -> Void))
    func generateFrontOrderReferenceId(forBrandId brandId: Int,withUserId userId: String) -> String
  }

