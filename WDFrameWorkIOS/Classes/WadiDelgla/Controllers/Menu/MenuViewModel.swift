//
//  MenuViewModel.swift
//  STDobites
//
//  Created by SimpleTouch on 11/13/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import ReactiveKit
//import DAL
//import BLL
import SVProgressHUD
//import RealmSwift
protocol IMenuViewModel: IBaseViewModel {
    var apiClient: MenuServiceBLL? { get set }
    var cartService: CartServiceBLL? {get set}
    var categoryList :[ICategoryMenuItemsDTODAL]? {get set}
    var delegate: IMenuViewController? {get set}
    var requestCategoryListDTO: IRequestCategoryListDTODAL? {get set}
    func getCategoryList()
    func viewDidLoad()
    func addItemTapped(_ item: IMenuItemsDTODAL)
    
 }

class MenuViewModel: IMenuViewModel{
    weak var delegate: IMenuViewController?
    var apiClient: MenuServiceBLL?
    var categoryList :[ICategoryMenuItemsDTODAL]?
    var requestCategoryListDTO: IRequestCategoryListDTODAL?
    var cartService: CartServiceBLL?
    
    
    public  init (requestCategoryListDTO: IRequestCategoryListDTODAL, apiClient: MenuServiceBLL,cartService: CartServiceBLL){
        self.apiClient = apiClient
        self.cartService = cartService
        self.requestCategoryListDTO = requestCategoryListDTO
     }
   
    func viewDidLoad(){
            self.requestCategoryListDTO?.pageIndex.value = 1
            self.requestCategoryListDTO?.pageSize.value = 1000
        self.requestCategoryListDTO?.areaId.value = Int(UserDefaults.currentArea?.id.value?.description ?? "0")
            self.requestCategoryListDTO?.brandId.value = K.shared.SELECTED_BRAND?.brandId.value ?? 0
     }
    func getCategoryList() {
        self.showHud()
        self.delegate?.onReloadTableView()
        doInBackground {
            self.apiClient?.getMenuItems(self.requestCategoryListDTO!) { (response) in
                doOnMain {
                    self.hideHUD()
                    guard let data = response?.data else {
                        if response?.error?.APIError != nil {
                            self.delegate?.onError(response?.error?.APIError?.description ?? "")
                        }
                        if response?.error?.networkError != nil {
                            self.delegate?.onError(response?.error?.networkError?.description ?? "")
                        }
                        return
                    }
                    self.categoryList = data as? [ICategoryMenuItemsDTODAL]
                    self.delegate?.onReloadTableView()
                    self.delegate?.onReloadCategoryCollectionView()
                    self.delegate?.updateBageCount()
                 }
            }
        }
    }
    
//    func addItemTapped(_ item: IMenuItemsDTO){
//
//        guard let isBrandOpen = K.shared.SELECTED_BRAND?.isOpen.value ,isBrandOpen else{
//            self.delegate?.onShowToast(R.string.localizable.branch_not_open(K.shared.SELECTED_BRAND?.openTime.value ?? "", K.shared.SELECTED_BRAND?.closeTime.value ?? ""))
//            return
//        }
//        guard self.cartService?.checkIfSameCurrentCart(K.shared.SELECTED_BRAND?.brandId.value ?? 0) == true else {
//            self.delegate?.onShowClearCartAlert({ (clear) in
//                if clear {
//                     self.delegate?.showProductViewController(item)
//                }
//            })
//            return
//        }
//        self.delegate?.showProductViewController(item)
//    }
    
    func addItemTapped(_ item: IMenuItemsDTODAL){
            
            guard let isBrandOpen = K.shared.SELECTED_BRAND?.isOpen.value ,isBrandOpen else{
                self.delegate?.onShowToast(R.string.localizable.branch_not_open(K.shared.SELECTED_BRAND?.openTime.value ?? "", K.shared.SELECTED_BRAND?.closeTime.value ?? ""))
                return
            }
            guard self.cartService?.checkIfSameCurrentCart(K.shared.SELECTED_BRAND?.brandId.value ?? 0) == true else {
                self.delegate?.onShowClearCartAlert({ (clear) in
                    if clear {
                        self.checkSizesAndChoicesCount(item)
                    }
                })
                return
            }
            self.checkSizesAndChoicesCount(item)
        }
        
        func checkSizesAndChoicesCount(_ item : IMenuItemsDTODAL){
            if !(item.isItemHasMultipleSize.value ?? false){
                if !(item.sizes.value?[0].choiceGroups.value?.count ?? 0 > 0){
                    self.addItemToCart(item)
                    return
                }
            }
            self.delegate?.showProductViewController(item)
        }
        func addItemToCart(_ item : IMenuItemsDTODAL) {
            self.showHud()
            
            guard let brand =  K.shared.SELECTED_BRAND
                else {
                    self.hideHUD()
                    return
            }
            if item.sizes.value?.count == 1 {
                item.sizes.value?[0].isSelected.value = true
            }
            self.cartService?.AddItemToCart((item.copy() as? IMenuItemsDTODAL)!,for: brand,areaId: Int(UserDefaults.currentArea?.id.value?.description ?? "0")!, completion: { (response) in
                doOnMain {
                    self.hideHUD()
                    guard let model = response?.data else {
                        self.delegate?.onShowToast("\((response?.error?.validateError as? ICartValidationDTOBLL)?.msgError.value ?? "")")
                        return
                    }
                    guard let success = model as? Bool,success else { return }
                    doOnMain(deadline: 0.0, {
                        self.delegate?.onShowToast("success_add_item".localized())
                        self.delegate?.vibrationDeviceAfterAddItem()
                        self.delegate?.updateBageCount()
                    })
                }
            })
            
        }
    
}
