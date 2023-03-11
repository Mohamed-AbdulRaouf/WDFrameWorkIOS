//
//  RealmCartUseCases.swift
//  BLL
//
//  Created by SimpleTouch on 11/17/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
////import DAL
import SwiftyJSON
public class CartUseCasesBLL : CartServiceBLL  {
    
    
    public init(){}
    /// This Function to get Offline Cart
    ///
    /// - Returns: it returns The saved Cart
    public func getCart() -> STCheckoutOrderDTODAL? {
        return UserDefaults.order
    }
    
    
    /// This Function check if user changed selected Brand
    ///
    /// - Parameter brandId: Item's Brand Id
    /// - Returns: it returns if added items from the same brand in saved cart or from another one
    public func checkIfSameCurrentCart(_ brandId: Int) -> Bool{
        //no items in cart
        guard let cart = UserDefaults.order else { return true }
        return cart.brandId == brandId
    }
    /// This Function to delete saved cart
    ///
    /// - Parameter completion: it returns that cart deleted successfully from the offline
    public func deleteCart(completion: @escaping ((Bool) -> Void)) {
        UserDefaults.order = nil
        completion(true)
    }
    /// This Function to set cart object offline
    ///
    /// - Parameters:
    ///   - cart: Cart object to be saved offline
    ///   - completion: it returns that cart successfully saved offline
    public func setCart(_ cart: STCheckoutOrderDTODAL,completion: @escaping ((Bool) -> Void)){
        UserDefaults.order = cart
        completion(true)
    }
    /// This Function checks if item added before to cart by using Visual Code , if exist increase amount of it and update item
    ///
    /// - Parameters:
    ///   - cart: saved cart object
    ///   - chosenItem: choosen item
    /// - Returns: it returns if item exist in Current Cart or not
    public func isItemInCart(cart: STCheckoutOrderDTODAL,chosenItem: STCartItemDTODAL) -> Bool
    {
        var isItemExist = false
        guard cart.cartItems.count > 0 else { return false }
        for item in cart.cartItems {
            print("item -> visualCode",item.visualCode,
                  "chosenItem -> visualCode",chosenItem.visualCode)
            if item.visualCode == chosenItem.visualCode {
                isItemExist = true
                item.amount = (item.amount ) + 1
                item.subTotal = (Double(chosenItem.amount ) * (item.priceWithChoices ))
                item.itemComment = chosenItem.itemComment
            }
        }
        return isItemExist
    }
    
    /// This Function To add new item to cart
    ///
    /// - Parameters:
    ///   - itemDTO: Item Object that user selected to be added to Cart
    ///   - brand: Selected Item's Brand Id
    ///   - areaId: Current Area Id
    ///   - completion: This returns success or faild add item to cart
    public func AddItemToCart(_ itemDTO:IMenuItemsDTODAL,for brand: IBrandDTODAL,areaId: Int,completion: @escaping onSuccessBLL){
        
        //validate data
        let validationDTO = CartValidationDTOBLL()
        let validation = CartValidationManagerBLL(errorModel: validationDTO)
        
        guard validation.validate(model: itemDTO) else {
            completion(STResponseBLL(data: nil,error: STErrorBLL(validateError: validationDTO, APIError: nil)))
            return
        }
        print("try add item to cart")
        
        let cartItem = STCartItemDTODAL()
        cartItem.visualCode.append(String(itemDTO.itemID.value ?? 0))
        cartItem.itemId = itemDTO.itemID.value ?? 0
        cartItem.itemName = itemDTO.itemName.value ?? ""
        cartItem.itemImage = itemDTO.imagePath.value ?? ""
        cartItem.amount = 1
        cartItem.itemComment = itemDTO.itemComment.value ?? ""
        cartItem.itemPrice = Double(itemDTO.itemPrice.value ?? 0.0)
        cartItem.itemCurrencyCode = itemDTO.currencyCode.value ?? ""
        
        var sumOfSelectedChoices: Float = 0
        var itemChoiceCart:STItemAttributeDTODAL!
        
        if let sizes = itemDTO.sizes.value,sizes.count > 0,let selectedSize = sizes.first(where: {$0.isSelected.value ?? false}){
            if let choiceGroups = selectedSize.choiceGroups.value, choiceGroups.count > 0{
                for choic in choiceGroups {
                    cartItem.itemSizeId = choic.choiceGroupId.value ?? 0
                    if let choices = choic.choices.value {
                        let selectedChoicesIds = choices.filter({$0.isSelectedChoice.value ?? false})
                        
                        for itemChoic in choices {
                            if selectedChoicesIds.contains(where: {$0.choiceId.value ?? 0 == itemChoic.choiceId.value ?? 0})
                            {
                                
                                cartItem.visualCode.append(String(itemChoic.choiceId.value ?? 0))
                                itemChoiceCart = STItemAttributeDTODAL()
                                
                                itemChoiceCart.choiceId = itemChoic.choiceId.value ?? 0
                                itemChoiceCart.itemId = itemChoic.choiceId.value ?? 0
                                itemChoiceCart.sizeId = itemChoic.itemChoiceSizeID.value ?? 0
                                itemChoiceCart.itemChoicePrice = itemChoic.choicePrice.value ?? 0.0
                                itemChoiceCart.itemChoiceName = itemChoic.choiceName.value ?? ""
                                itemChoiceCart.amount = 1
                                sumOfSelectedChoices = sumOfSelectedChoices + (itemChoic.choicePrice.value ?? 0.0)
                                cartItem.choices.append(itemChoiceCart)
                            }
                        }
                    }
                }
            }
            cartItem.visualCode.append(String(selectedSize.sizeId.value ?? 0))
            cartItem.itemSizeId = selectedSize.sizeId.value ?? 0
            cartItem.itemPrice = Double(selectedSize.sizePrice.value ?? 0.0)
            cartItem.sizeId = selectedSize.sizeId.value ?? 0
            cartItem.sizeName = selectedSize.sizeName.value ?? ""
            cartItem.priceWithChoices = Double((selectedSize.sizePrice.value ?? 0.0) + sumOfSelectedChoices)
            cartItem.subTotal = Double((selectedSize.sizePrice.value ?? 0.0) + sumOfSelectedChoices)
        }
        var cart = getCart()
        if cart == nil {
            cart = STCheckoutOrderDTODAL()
            cart?.brandId = brand.brandId.value ?? 0
            cart?.isOnlinePayment = brand.isOnLinePayment.value ?? false
            cart?.isBrandDeliveryAtStore = brand.deliveryAtStore.value ?? false
        }
        if cart?.frontOrderReferenceId == "" ,let userId = UserDefaults.user?.userId.value,userId != "" {
            cart?.frontOrderReferenceId = self.generateFrontOrderReferenceId(forBrandId: brand.brandId.value ?? 0, withUserId: userId)
        }
        if !isItemInCart(cart:cart!,chosenItem: cartItem) {
            
            if let cart = cart{
                cart.cartItems.append(cartItem)
                cart.brandImage = brand.brandLogoPath.value ?? ""
                cart.brandName = brand.brandName.value ?? ""
                cart.maxRedeemAmount = brand.maxRedeemAmount.value ?? 0.0
                cart.minRedeemAmount = brand.minRedeemAmount.value ?? 0.0
                cart.myPoints = brand.currentCustomerPointsInBrand.value ?? 0
                cart.equivalentAmount = Double(brand.equivalentPointsAmount.value ?? 0.0)
                cart.currencyCode = brand.currency.value ?? ""
                cart.allowCouponRedeem = brand.allowRedeemWithCouponDiscount.value ?? false
                cart.isCustomerRegisterInBrand = brand.currentCustomerIsRegistered.value ?? false
                cart.selectedAreaId = areaId
                cart.isOnlinePayment = brand.isOnLinePayment.value ?? false
                cart.isBrandDeliveryAtStore = brand.deliveryAtStore.value ?? false
            }
            
        }
        self.setCart(cart!) { (success) in
            if success {
                completion(STResponseBLL(data: true,error: STErrorBLL(validateError: nil, APIError: nil)))
            }
        }
    }
    public func AddItemToCart(_ itemDTO:IMenuItemsDTODAL,_ brand: IBrandDTODAL,_ areaId: Int,_ userId: String,completion: @escaping onSuccessBLL) {
        //validate data
        let validationDTO = CartValidationDTOBLL()
        let validation = CartValidationManagerBLL(errorModel: validationDTO)
        
        guard validation.validate(model: itemDTO) else {
            completion(STResponseBLL(data: nil,error: STErrorBLL(validateError: validationDTO, APIError: nil)))
            return
        }
        print("try add item to cart")
        
        let cartItem = STCartItemDTODAL()
        cartItem.visualCode.append(String(itemDTO.itemID.value ?? 0))
        cartItem.itemId = itemDTO.itemID.value ?? 0
        cartItem.itemName = itemDTO.itemName.value ?? ""
        cartItem.itemImage = itemDTO.imagePath.value ?? ""
        cartItem.amount = 1
        cartItem.itemComment = itemDTO.itemComment.value ?? ""
        cartItem.itemPrice = Double(itemDTO.itemPrice.value ?? 0.0)
        cartItem.itemCurrencyCode = itemDTO.currencyCode.value ?? ""
        
        var sumOfSelectedChoices: Float = 0
        var itemChoiceCart:STItemAttributeDTODAL!
        
        if let sizes = itemDTO.sizes.value,sizes.count > 0,let selectedSize = sizes.first(where: {$0.isSelected.value ?? false}){
            if let choiceGroups = selectedSize.choiceGroups.value, choiceGroups.count > 0{
                for choic in choiceGroups {
                    cartItem.itemSizeId = choic.choiceGroupId.value ?? 0
                    if let choices = choic.choices.value {
                        let selectedChoicesIds = choices.filter({$0.isSelectedChoice.value ?? false})
                        
                        for itemChoic in choices {
                            if selectedChoicesIds.contains(where: {$0.choiceId.value ?? 0 == itemChoic.choiceId.value ?? 0})
                            {
                                
                                cartItem.visualCode.append(String(itemChoic.choiceId.value ?? 0))
                                itemChoiceCart = STItemAttributeDTODAL()
                                
                                itemChoiceCart.choiceId = itemChoic.choiceId.value ?? 0
                                itemChoiceCart.itemId = itemChoic.choiceId.value ?? 0
                                itemChoiceCart.sizeId = itemChoic.itemChoiceSizeID.value ?? 0
                                itemChoiceCart.itemChoicePrice = itemChoic.choicePrice.value ?? 0.0
                                itemChoiceCart.itemChoiceName = itemChoic.choiceName.value ?? ""
                                itemChoiceCart.amount = 1
                                sumOfSelectedChoices = sumOfSelectedChoices + (itemChoic.choicePrice.value ?? 0.0)
                                cartItem.choices.append(itemChoiceCart)
                            }
                        }
                    }
                }
            }
            cartItem.visualCode.append(String(selectedSize.sizeId.value ?? 0))
            cartItem.itemSizeId = selectedSize.sizeId.value ?? 0
            cartItem.itemPrice = Double(selectedSize.sizePrice.value ?? 0.0)
            cartItem.sizeId = selectedSize.sizeId.value ?? 0
            cartItem.sizeName = selectedSize.sizeName.value ?? ""
            cartItem.priceWithChoices = Double((selectedSize.sizePrice.value ?? 0.0) + sumOfSelectedChoices)
            cartItem.subTotal = Double((selectedSize.sizePrice.value ?? 0.0) + sumOfSelectedChoices)
        }
        var cart = getCart()
        if cart == nil {
            cart = STCheckoutOrderDTODAL()
            cart?.brandId = brand.brandId.value ?? 0
            cart?.isOnlinePayment = brand.isOnLinePayment.value ?? false
            cart?.isBrandDeliveryAtStore = brand.deliveryAtStore.value ?? false
//            cart?.frontOrderReferenceId = self.generateFrontOrderReferenceId(forBrandId: brand.brandId.value ?? 0, withUserId: userId)
        }
        
        if !isItemInCart(cart:cart!,chosenItem: cartItem) {
            
            if let cart = cart{
                cart.cartItems.append(cartItem)
                cart.brandImage = brand.brandLogoPath.value ?? ""
                cart.brandName = brand.brandName.value ?? ""
                cart.maxRedeemAmount = brand.maxRedeemAmount.value ?? 0.0
                cart.minRedeemAmount = brand.minRedeemAmount.value ?? 0.0
                cart.myPoints = brand.currentCustomerPointsInBrand.value ?? 0
                cart.equivalentAmount = Double(brand.equivalentPointsAmount.value ?? 0.0)
                cart.currencyCode = brand.currency.value ?? ""
                cart.allowCouponRedeem = brand.allowRedeemWithCouponDiscount.value ?? false
                cart.isCustomerRegisterInBrand = brand.currentCustomerIsRegistered.value ?? false
                cart.selectedAreaId = areaId
                cart.isOnlinePayment = brand.isOnLinePayment.value ?? false
                cart.isBrandDeliveryAtStore = brand.deliveryAtStore.value ?? false
            }
            
        }
        self.setCart(cart!) { (success) in
            if success {
                completion(STResponseBLL(data: true,error: STErrorBLL(validateError: nil, APIError: nil)))
            }
        }
    }

    /// This Function to increment count of item that exist in cart
    ///
    /// - Parameters:
    ///   - item: Item to be incremented
    ///   - completion: it returns success increment item's count
    public func increamentItem(_ item: ISTCartItemDTODAL,completion: @escaping ((Bool) -> Void)){
        guard let cart = UserDefaults.order ,cart.cartItems.count > 0 else{ return}
        cart.cartItems.first(where: {$0.visualCode == item.visualCode})?.increament()
        self.setCart(cart,completion:completion)
    }
    /// This Function to decrement count of item that exist in cart
    ///
    /// - Parameters:
    ///   - item: Item to be decreamented
    ///   - completion: It returns success decreamented item's count
    public func decreamentItem(_ item: ISTCartItemDTODAL,completion: @escaping ((Bool) -> Void)){
        guard let cart = UserDefaults.order ,cart.cartItems.count > 0 else{
            completion(false)
            return
        }
        if (item.amount == 1 && cart.cartItems.count == 1){
            self.deleteCart(completion: completion)
        }else {
            if item.amount == 1 {
                self.deleteItemFromCart(item,completion: completion)
            }else{
                guard let cart = UserDefaults.order ,cart.cartItems.count > 0 else{ return}
                cart.cartItems.first(where: {$0.visualCode == item.visualCode})?.decreament()
                self.setCart(cart,completion: completion)
            }
        }
    }
    /// This Function to delete item from cart
    ///
    /// - Parameters:
    ///   - item: Item to be deleted
    ///   - completion: This return success deleteditem from cart
    public func deleteItemFromCart(_ item: ISTCartItemDTODAL,completion: @escaping ((Bool) -> Void)){
        guard let cart = UserDefaults.order ,cart.cartItems.count > 0 else{ return}
        cart.cartItems.removeFirst(where: {$0.visualCode == item.visualCode})
        if cart.cartItems.count == 0
        {
            self.deleteCart { (success) in
            completion(success)
           }
        }else{
            self.setCart(cart,completion: completion)
        }
    }
    /// This Function to update item comment
       ///
       /// - Parameters:
       ///   - visualCode: The visualCode of Item to update it's comment
       ///   - comment: comment
       ///   - completion: This return success updated Comment in Cart
    public  func updateItemComment(_ visualCode: String,_ comment: String,completion: @escaping ((Bool) -> Void)){
          guard let cart = UserDefaults.order ,cart.cartItems.count > 0 else{ return}
        cart.cartItems.first(where: {$0.visualCode == visualCode})?.updateItemComment(comment)
          self.setCart(cart,completion:completion)
      }
    public func updateOrderComment(_ comment: String,completion: @escaping ((Bool) -> Void)){
         guard let cart = UserDefaults.order ,cart.cartItems.count > 0 else{ return}
        cart.orderComment = comment
        self.setCart(cart,completion: completion)
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
}
