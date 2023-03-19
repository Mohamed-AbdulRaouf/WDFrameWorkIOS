//
//  ExploreViewModel.swift
//  STDobites
//
//  Created by SimpleTouch on 11/6/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import ReactiveKit
//import DAL
//import BLL
import SVProgressHUD
protocol IExploreViewModel: IBaseViewModel {
    var apiClient: BrandServiceBLL? { get set }
    var userService: UserServiceBLL? { get set }
    var filterAndSeviceList: IFilterationListDTODAL? {get set}
    var brand :IBrandListDTODAL? {get set}
    var requestBrandDTO: IRequestBrandDTODAL? {get set}
    var delegate: IExploreViewController? {get set}
    var brandInfo :IBrandDTODAL? {get set}
    func getServices()
    func getBrandList()
     func initdata()
    func handleCusiniesAndFacilitiesData()
    func selectSort(atIndex index:Int)
    func setCusiniesAndFacilities(_ cusinies: [String], _ facilities: [String])
    func clearData()
    func registerUserInBrand(_ index: Int)
    func checkIfChangeLoyalty()
    func refreshList()
    func getBrandInfoById(_ brandId: String)
}
class ExploreViewModel: IExploreViewModel{
    var brand :IBrandListDTODAL?
    var filterAndSeviceList: IFilterationListDTODAL?
    var requestBrandDTO: IRequestBrandDTODAL?
    var apiClient: BrandServiceBLL?
    var userService: UserServiceBLL?
    weak var delegate: IExploreViewController?
    var brandInfo: IBrandDTODAL?
    
    public  init (requestBrandDTO: IRequestBrandDTODAL, apiClient: BrandServiceBLL,userService: UserServiceBLL){
        self.apiClient = apiClient
        self.userService = userService
        self.requestBrandDTO = requestBrandDTO
    }
    
    func initdata(){
        
        self.brand?.items.value?.removeAll()
        //for I crave
        self.requestBrandDTO?.feedMe.value = "0"
        self.requestBrandDTO?.lang.value = K.shared.APP_LANGUAGE
        self.requestBrandDTO?.pageIndex.value = "1"
        self.requestBrandDTO?.pageSize.value = "1000"
        self.requestBrandDTO?.serviceIDs.value = "0"
        self.requestBrandDTO?.sortID.value = "0"
        self.requestBrandDTO?.areaID.value = Int((UserDefaults.currentArea?.id.value)!)
        self.requestBrandDTO?.brandsMe.value = (TabsData.sharedInstance.isLoyality ?? false ) ? 1 : 0
        
        self.requestBrandDTO?.brandName.value = ""
        self.handleCusiniesAndFacilitiesData()
    }
    func handleCusiniesAndFacilitiesData(){
        if let cusinies = UserDefaults.recentCuisineFilterSearches {
            self.requestBrandDTO?.cusineIDs.value = cusinies.count > 0 ? cusinies.joined(separator: ",") : "0"
        }else{
            self.requestBrandDTO?.cusineIDs.value = "0"
        }
        if let facilities = UserDefaults.recentFaciltiesFilterSearches {
            self.requestBrandDTO?.facilityIDs.value = facilities.count > 0 ? facilities.joined(separator: ",") : "0"
        }else{
            self.requestBrandDTO?.facilityIDs.value = "0"
        }
    }
    func getServices() {
        self.showHud()
         self.filterAndSeviceList = nil
        doInBackground {
            self.apiClient?.getBrandFilterationAndServicesList() { (response) in
                doOnMain {
                    self.hideHUD()
                    guard let data = response?.data else { return }
                    self.filterAndSeviceList = data as? IFilterationListDTODAL
                    self.filterAndSeviceList?.serviceList.value?.insert(ServiceDTODAL(id: "0", name: R.string.localizable.all_service(),icon: ""), at: 0)
                    self.delegate?.onReloadServiceCollectionView()
                }
            }
        }
    }
    func getBrandList() {
        self.showHud()
        self.delegate?.onReloadTableView()
        doInBackground {
            self.apiClient?.getBrandList(self.requestBrandDTO!) { (response) in
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
                    if let brandDTO = data as? IBrandListDTODAL {
                        if self.brand == nil {
                            self.brand = brandDTO
                        }else{
                            self.brand?.items.value?.append(contentsOf: brandDTO.items.value!)
                        }
                        self.delegate?.onReloadTableView()
                    }
                }
            }
        }
    }
    func checkIfChangeLoyalty(){
        if self.requestBrandDTO?.brandsMe.value != ((TabsData.sharedInstance.isLoyality ?? false ) ? 1 : 0 ){
            self.brand = nil
//            self.brand?.items.value?.removeAll()
            self.requestBrandDTO?.brandsMe.value = (TabsData.sharedInstance.isLoyality ?? false ) ? 1 : 0
            self.getBrandList()
        }
    }
    func selectSort(atIndex index:Int){
        self.brand = nil
//        self.brand?.items.value?.removeAll()
        self.requestBrandDTO?.sortID.value = self.filterAndSeviceList?.sortList.value?[index].id.value ?? "0"
        self.getBrandList()
    }
    func setCusiniesAndFacilities(_ cusinies: [String], _ facilities: [String]){
        self.brand = nil
//        self.brand?.items.value?.removeAll()
        UserDefaults.recentCuisineFilterSearches = cusinies
        UserDefaults.recentFaciltiesFilterSearches = facilities
        self.handleCusiniesAndFacilitiesData()
        self.getBrandList()
    }
    func clearData(){
        self.brand = nil
    }
    func registerUserInBrand(_ index: Int){
        guard let brandId = self.brand?.items.value?[index].brandId.value else { return }
        guard let _ =  UserDefaults.user else {
            self.delegate?.openLogin()
            return
        }
        self.showHud()
        self.delegate?.onReloadTableView()
        doInBackground {
            self.userService?.registerUserInBrand(brandId, completion: { (response) in
                doOnMain {
                    self.hideHUD()
                    guard let _ = response?.data else {
                        if response?.error?.APIError != nil {
                            self.delegate?.onError(response?.error?.APIError?.description ?? "")
                        }
                        if response?.error?.networkError != nil {
                            self.delegate?.onError(response?.error?.networkError?.description ?? "")
                        }
                        return
                    }
                    self.delegate?.onShowToast(R.string.localizable.success_register_to_brand())
                        self.initdata()
                     self.delegate?.onReloadTableView()
                    self.getBrandList()
                    
                }
            })
            
        }
    }
    func refreshList(){
        self.brand = nil
        self.requestBrandDTO?.pageIndex.value = "1"
        self.getBrandList()
        doInBackground {
            self.getServices()
        }
    }
    
    func getBrandInfoById(_ brandId: String) {
        guard brandId != "0" else {return}
        self.showHud()
        doInBackground {
            self.apiClient?.getBrandInfoById(brandId) { (response) in
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
                    self.brandInfo = data as? IBrandDTODAL
                    self.delegate?.onSuccessLoadBrandInfo()
                }
            }
        }
    }
    
}
