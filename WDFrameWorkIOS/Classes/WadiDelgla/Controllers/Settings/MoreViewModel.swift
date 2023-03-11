//
//  MoreViewModel.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 10/30/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import ReactiveKit
//import DAL
//import BLL
import SVProgressHUD
protocol IMoreViewModel:IBaseViewModel {
    
    var delegate: IMoreProtocol? { get set }
    var apiClient: UserServiceBLL? { get set }
    var cartService : CartServiceBLL? {get set}
    var moreItems : [MoreItemDTODAL]? {get set}
    
    func viewDidload()
    func didSelectItem(_ indexPathRow:Int)
    func registerToBrand(_ referralCode: String)
//    func validateOnCartHasItems()
    func validateOnCartHasItemsForCountry(country: ICountryDTODAL)
    func validateOnCartHasItemsForLang()
}


class MoreViewModel: IMoreViewModel{
    
    weak var delegate: IMoreProtocol?
    var moreItems: [MoreItemDTODAL]?
    var apiClient: UserServiceBLL?
    var cartService: CartServiceBLL?
    public  init (apiClient: UserServiceBLL,cartService : CartServiceBLL){
        self.apiClient = apiClient
        self.cartService = cartService
    }
    
    func viewDidload(){
        self.setupUI()
    }
    enum MoreSectionNames : String{
        case referral_code = "referral code"
        case change_location = "change location"
        case sign_in = "sign in"
        case sign_out = "sign out"
        case my_orders = "my orders"
        case about_dobites = "about dobites"
        case bar_code = "bar code"
        case language = "language"
        case favorites = "favorites"
    }
    let sectionNames : [MoreSectionNames] = [.change_location,.favorites,.my_orders,.language,.bar_code,.about_dobites,.sign_in]
    
    func setupUI(){
        self.moreItems = [MoreItemDTODAL]()
        
//        self.moreItems?.append(MoreItemDTO(R.string.localizable.change_country(), R.image.ic_change_location.name))
        
        self.moreItems?.append(MoreItemDTODAL(R.string.localizable.change_location(), R.image.ic_change_location.name))
        
//        self.moreItems?.append(MoreItemDTO(R.string.localizable.favorites(), R.image.ic_heart_black.name))
        
        self.moreItems?.append(MoreItemDTODAL(R.string.localizable.my_orders(), R.image.ic_order.name))
        
        
        self.moreItems?.append(MoreItemDTODAL(R.string.localizable.language(), R.image.ic_change_lang.name))
        
        self.moreItems?.append(MoreItemDTODAL(R.string.localizable.bar_code(), R.image.ic_bar_code.name))
        
        
        //        self.moreItems?.append(MoreItemDTO(R.string.localizable.referral_code(), R.image.ic_gift_gray.name))
        
//        self.moreItems?.append(MoreItemDTO(R.string.localizable.about_doBites(), R.image.ic_dobites.name))
        
        if UserDefaults.user != nil {
            self.moreItems?.append(MoreItemDTODAL(R.string.localizable.sign_out(), R.image.ic_exit.name))
        }else{
            self.moreItems?.append(MoreItemDTODAL(R.string.localizable.sign_in(), R.image.ic_exit.name))
        }
        self.delegate?.onReloadTable()
    }
    
    func registerToBrand(_ referralCode: String) {
        self.showHud()
        doInBackground {
            self.apiClient?.registerToBrandByReferralCode(referralCode,0,completion: { (response) in
                doOnMain {
                    self.hideHUD()
                    guard (response?.data) != nil else {
                        if response?.error?.APIError != nil {
                            self.delegate?.onError(response?.error?.APIError?.description ?? "")
                        }
                        if response?.error?.networkError != nil {
                            self.delegate?.onError(response?.error?.networkError?.description ?? "")
                        }
                        return
                    }
                    self.delegate?.onSuccessRegisterToBrand()
                }
            })
        }
    }
//    func validateOnCartHasItems(){
//        guard  cartService?.getCart() == nil else{
//            self.delegate?.onShowClearCartByChangingLanguage()
//            return
//        }
//        changeLanguage()
//    }
    func validateOnCartHasItemsForLang() {
        
        guard  cartService?.getCart() == nil else{
            self.delegate?.onShowClearCartAlert(messageText: R.string.localizable.clear_cart_due_to_change_language(), actionButtonText: R.string.localizable.clear_cart(), actionButtonClosure: {
                self.cartService?.deleteCart(completion: { (success) in
                    if success {
                        changeLanguage()
                    }
                })
            })
            return
        }
        changeLanguage()
    }
    func validateOnCartHasItemsForCountry(country: ICountryDTODAL) {
           guard  cartService?.getCart() == nil else{
               self.delegate?.onShowClearCartAlert(messageText: R.string.localizable.clear_cart_due_to_change_country(), actionButtonText: R.string.localizable.clear_cart(), actionButtonClosure: {
                   self.cartService?.deleteCart(completion: { (success) in
                       if success {
                           changeCountry(withCountry: country)
                       }
                   })
               })
               return
           }
           changeCountry(withCountry: country)
       }
    func onFavoriteResturantsTapped() {
        if let token =  UserDefaults.user?.token.value ,token != "" {
            TabsData.sharedInstance.searchTerm = ""
            TabsData.sharedInstance.isLoyality = true
            self.delegate?.openExplore()
        }else{
            self.delegate?.openLogin()
        }
    }
    
    func didSelectItem(_ row:Int){
        if  self.moreItems?[row].itemName == R.string.localizable.referral_code() {
            guard let _ = UserDefaults.user else{
                self.delegate?.openLogin()
                return
            }
            self.delegate?.openReferralCode()
        }else if self.moreItems?[row].itemName == R.string.localizable.change_location(){
            self.delegate?.openLocation()
        }else if self.moreItems?[row].itemName == R.string.localizable.change_country(){
            self.delegate?.openCountryList()
        }else if self.moreItems?[row].itemName == R.string.localizable.sign_in() {
            self.delegate?.openLogin()
        }else if self.moreItems?[row].itemName == R.string.localizable.sign_out() {
            UserDefaults.user = nil
             UserDefaults.loginData = nil
            self.setupUI()
        }else if self.moreItems?[row].itemName == R.string.localizable.my_orders() {
            guard let _ = UserDefaults.user else{
                self.delegate?.openLogin()
                return
            }
            self.delegate?.openOrderList()
        }else if self.moreItems?[row].itemName == R.string.localizable.about_doBites() {
            self.delegate?.openAboutDoBites()
        }else if self.moreItems?[row].itemName == R.string.localizable.bar_code() {
            guard let _ = UserDefaults.user else{
                self.delegate?.openLogin()
                return
            }
            self.delegate?.openBarCode()
        }else if self.moreItems?[row].itemName == R.string.localizable.language(){
            self.validateOnCartHasItemsForLang()
        }else if self.moreItems?[row].itemName == R.string.localizable.favorites(){
            self.onFavoriteResturantsTapped()
        }
    }
    
}
