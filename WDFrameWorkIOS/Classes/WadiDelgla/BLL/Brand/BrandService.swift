//
//  BrandService.swift
//  BLL
//
//  Created by Nermeen Mohamed on 10/28/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Alamofire
////import DAL
//MARK:- Brand
public protocol BrandServiceBLL :AnyObject {
    func getAdsList(pagingDTO:IPagingDTODAL,completion: @escaping onSuccessBLL)
    func getBranchsNearBy(_ lat: Double,_ long: Double,completion: @escaping onSuccessBLL)
    func getBrandsNotifications(_ requestNotificationDTO:IRequestDTODAL,completion: @escaping onSuccessBLL)
    func getBrandNotifications(_ requestNotificationDTO:IRequestDTODAL,completion: @escaping onSuccessBLL)
    func removeNotification(_ notificationId: String,completion: @escaping onSuccessBLL)
    func readNotification(_ notificationId: String,completion: @escaping onSuccessBLL)
    func getBrandInfoById(_ brandId: String,completion: @escaping onSuccessBLL)
    func getBrandLocationsByAreaId(_ areaId: String, brandId: String,completion: @escaping onSuccessBLL)
    func getBrandList(_ requestBrandDTO: IRequestBrandDTODAL, completion: @escaping onSuccessBLL)
    func getBrandFilterationAndServicesList(completion: @escaping onSuccessBLL)
    func getBrandsNotificationsCount(_ brandId: Int,completion: @escaping onSuccessBLL)
    func getBrandBranchList(_ brandId: Int,completion: @escaping onSuccessBLL)
    func getBrandPaymentData(_ areaId: String,_ brandId: Int,completion: @escaping onSuccessBLL)
    func getMyFatoorahBrandPaymentData(_ areaId: String,_ brandId: Int,completion: @escaping onSuccessBLL)

}

