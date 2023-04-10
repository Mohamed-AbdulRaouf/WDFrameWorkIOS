//
//  ProductViewModel.swift
//  STDobites
//
//  Created by SimpleTouch on 11/17/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import ReactiveKit
//import DAL
//import BLL
import SVProgressHUD
protocol IProductViewModel: IBaseViewModel {
    var delegate: IProductViewController? {get set}
    var product: IMenuItemsDTODAL? {get set}
    func getNumberOfSections() -> Int
    var selectedSizeIndex : Int? {get set}
    func onChoiceTappedAtIndex(_ index: IndexPath,_ isOn: Bool)
    func getCartDB()
    var cart: ISTCheckoutOrderDTODAL? {get set}
    var cartService: CartServiceBLL? {get set}
    func addItemToCart()
    func viewDidLoad()
}
class ProductViewModel: IProductViewModel{
    
    weak var delegate: IProductViewController?
    var product: IMenuItemsDTODAL?
    var selectedSizeIndex: Int?  = -1 {
        didSet{
            self.product?.sizes.value?.forEach({ (size) in
                size.isSelected.value = false
            })
            self.product?.sizes.value?[selectedSizeIndex!].isSelected.value = true
            self.delegate?.onReloadTableView()
        }
    }
    
    var cart: ISTCheckoutOrderDTODAL?
    var cartService: CartServiceBLL?
    public  init (cartService: CartServiceBLL){
        self.cartService = cartService
    }
    func viewDidLoad(){
        guard let sizes = self.product?.sizes.value , sizes.count > 0 else { return }
        // product details + special instructions + select size
        if sizes.count == 1 {selectedSizeIndex = 0}
    }
    func getNumberOfSections() -> Int{
        guard let sizes = self.product?.sizes.value , sizes.count > 0 else { return 0 }
        // product details + special instructions + select size
        guard let selectedSize = selectedSizeIndex,selectedSize != -1, let choicesGroups = sizes[selectedSizeIndex!].choiceGroups.value , choicesGroups.count > 0 else { return 3}
        // product details + special instructions + select size + choice group count
        return 1 + 1 + 1 + choicesGroups.count
    }
    func onChoiceTappedAtIndex(_ index: IndexPath,_ isOn: Bool) {
        self.product?.sizes.value?[self.selectedSizeIndex ?? 0].choiceGroups.value?[index.section - 2].choices.value?[index.row].isSelectedChoice.value = isOn
        let choiceGroup = self.product?.sizes.value?[self.selectedSizeIndex ?? 0].choiceGroups.value?[index.section - 2]
        let checkedCount =  choiceGroup?.choices.value?.count(where: {$0.isSelectedChoice.value ?? false})
        self.product?.sizes.value?[self.selectedSizeIndex ?? 0].choiceGroups.value?[index.section - 2].isSelectedMinMax.value = (checkedCount ?? 0 >= choiceGroup?.minChoiceSelected.value ?? 0 && checkedCount ?? 0 <= choiceGroup?.maxChoiceSelected.value ?? 0)
    }
    
}
extension ProductViewModel{
    func getCartDB() {
        self.cart = self.cartService?.getCart()
    }
   
    
    func addItemToCart() {
        self.showHud()
       
            guard let brand =  K.shared.SELECTED_BRAND
                else {
                    self.hideHUD()
                    return
            }
        self.cartService?.AddItemToCart(self.product!,for: brand,areaId: Int(UserDefaults.currentArea?.id.value?.description ?? "0")!, completion: { (response) in
                doOnMain {
                    self.hideHUD()
                    guard let model = response?.data else {
                        self.delegate?.onShowToast("\((response?.error?.validateError as? ICartValidationDTOBLL)?.msgError.value ?? "")")
                        return
                    }
                    guard let success = model as? Bool,success else { return }
                    doOnMain(deadline: 2.0, {
                        self.delegate?.onShowToast("success_add_item".localized())
                    })
                    self.delegate?.onDismissViewController()
                }
            })
        
    }
}
