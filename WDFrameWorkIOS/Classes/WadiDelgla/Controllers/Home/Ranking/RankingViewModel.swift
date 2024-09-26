//
//  RankingViewModel.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 10/29/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import ReactiveKit
import SVProgressHUD

protocol IRankingViewModel: IBaseViewModel {
    
    var apiClient: UserServiceBLL? { get set }
    var onReloadTable :  (() -> Void)? { get set }
    var onError: ((String) -> Void)? { get set }
    var rankingList :[ITopRatedReferralsDTODAL]? {get set}
    var totalValue : Int {get set}
    func getTopReferralsCustomers()
}
class RankingViewModel: IRankingViewModel{
    var totalValue: Int = 0
    var apiClient: UserServiceBLL?
    var onReloadTable: (() -> Void)?
    var onError: ((String) -> Void)?
    var rankingList: [ITopRatedReferralsDTODAL]?

    
    public  init (apiClient: UserServiceBLL){
        self.apiClient = apiClient
    }
    
     func getTopReferralsCustomers() {
        self.showHud()
        doInBackground {
            self.apiClient?.getTopReferralsCustomer(completion: { (response) in
                doOnMain {
                    self.hideHUD()
                    guard let data = response?.data else {
                        if response?.error?.APIError != nil {
                            self.onError!(response?.error?.APIError?.description ?? "")
                        }
                        if response?.error?.networkError != nil {
                            self.onError!(response?.error?.networkError?.description ?? "")
                        }
                        return
                    }
                    self.rankingList = data as? [ITopRatedReferralsDTODAL]
                    self.rankingList?.forEach({ (item) in
                        self.totalValue += item.referralsCount.value ?? 0
                    })
                    self.onReloadTable!()
                }
            })
            
        }
    }
    
}
