//
//  IBrandInfoViewModel.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 11/4/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import ReactiveKit
//import DAL
//import BLL
import SVProgressHUD
//import KashierPaymentSDK
protocol IBrandInfoViewModel: IBaseViewModel {
    var cellModels: Property<[IBrandHeaderInfoTableViewCellViewModel]>? { get }
    var apiClient: BrandServiceBLL? { get set }
    var brand :IBrandDTODAL? {get set}
    func getBrandInfoById(_ brandId: String)
    var delegate: IBrandInfoViewController? {get set}
    var shareUrlMessage : String? {get}
    func viewDidLoad()
    func onNotificationsTapped()
    var brandId: Int? {get set}
}
class BrandInfoViewModel: IBrandInfoViewModel{
    
    var shareUrlMessage: String?{
        get{
            return R.string.localizable.share_code_message("\(self.brand?.shareUrl.value ?? "" )", "\(self.brand?.brandName.value ?? "")", "\(self.brand?.shareCode.value ?? "")")
            
        }
    }
    
    var cellModels: Property<[IBrandHeaderInfoTableViewCellViewModel]>?
    
    weak var delegate: IBrandInfoViewController?
    
    var apiClient: BrandServiceBLL?
    
    var brand: IBrandDTODAL?
    
    var brandId: Int?
    
    public  init (apiClient: BrandServiceBLL){
        self.apiClient = apiClient
    }
    func viewDidLoad(){
        self.getBrandInfoById(String(self.brandId ?? 0))
    }
    func getBrandInfoById(_ brandId: String){
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
                    self.brand = data as? IBrandDTODAL
                    self.delegate?.onSuccessLoadBrandInfo()
                }
            }
        }
    }
    
    func onNotificationsTapped() {
        if let token =  UserDefaults.user?.token.value ,token != "" {
            self.delegate?.openNotificationList()
        }else{
            self.delegate?.openLogin()
        }
    }

}
