//
//  BrandRoute.swift
//  BLL
//
//  Created by Nermeen Mohamed on 10/28/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Alamofire
////import DAL
enum BrandRouteBLL: URLRequestBuilderBLL {
    
    
    // home
    case getAdList(pagingDTO:IPagingDTODAL)
    case getBranchsNearBy(lat:Double,long:Double)
    case getBrandsNotifications(requestDTO: IRequestDTODAL)
    case getBrandNotifications(requestDTO: IRequestDTODAL)
    case removeNotification(notificationId: String)
    case readNotification(notificationId: String)
    case getBrandInfoById(brandId: String)
    case getBrandLocationsByAreaId(areaId: String, brandId: String)
    case getBrandList(requestBrandDTO: IRequestBrandDTODAL)
    case getBrandFilterationList
    case getBrandsNotificationsCount(brandId: Int)
    case getBrandBranchList(brandId: Int)
    case getBrandPaymentData(areaId: String, brandId: Int)
    case getMyFatoorahBrandPaymentData(areaId: String, brandId: Int)
    // MARK: - Path
    internal var path: ServerPathsBLL {
        switch self {
        case .getAdList:
            return .GET_ADS_LIST
        case .getBranchsNearBy:
            return .GET_BRANCHES_NEAR_BY
        case .getBrandsNotifications:
            return .GET_BRANDS_NOTIFICATIONS
        case .getBrandNotifications:
            return .GET_BRAND_NOTIFICATIONS
        case .removeNotification:
            return .REMOVE_NOTIFICATION
        case .readNotification:
            return . READ_NOTIFICATION
        case .getBrandInfoById:
            return .GET_BRAND_INFO_BY_ID
        case .getBrandLocationsByAreaId:
            return .GET_BRAND_LOCATION_BY_AREA_ID
        case .getBrandList:
            return .GET_BRAND_LIST
        case .getBrandFilterationList:
            return .GET_BRAND_FILTERATION_LIST
        case .getBrandsNotificationsCount:
            return .GET_BRANDS_NOTIFICATION_COUNT
        case .getBrandBranchList:
            return .GET_BRAND_BRANCHES
        case .getBrandPaymentData:
            return .GET_BRAND_PAYMENT_DATA
        case .getMyFatoorahBrandPaymentData:
            return .GET_MY_FATOORAH_BRAND_PAYMENT_DATA
        }
    }
   
    // MARK: - Parameters
    internal var parameters: Parameters? {
        var params = defaultParams
        switch self {
        case  .getAdList,.getBranchsNearBy,.getBrandsNotifications,.getBrandNotifications,.removeNotification,.readNotification:
            break
        default:
            break
        }
        return params
    }
    internal var headers: HTTPHeaders {
        let default_headers = defaultHeaders
           return default_headers
       }
    internal var urlParameters: [String]? {
        var params = [String]()
        switch self {
        case let .getAdList(pagingDTO):

           params.append(Config.language)
            params.append(String(pagingDTO.pageNumber.value!))
            params.append(String(pagingDTO.pageSize.value!))
        case let .getBranchsNearBy(lat, long):
            params.append(String(lat))
            params.append(String(long))
            params.append(Config.language)
        case let .getBrandsNotifications(requestDTO):
            params.append(String(requestDTO.brandId.value ?? 0))
            params.append(Config.language)
            params.append(String(requestDTO.pageNumber.value ?? 0))
            params.append(String(requestDTO.pageSize.value ?? 0))
        case let .getBrandNotifications(requestDTO):
            params.append(String(requestDTO.brandId.value ?? 0))
            params.append(Config.language)
            params.append(String(requestDTO.pageNumber.value ?? 0))
            params.append(String(requestDTO.pageSize.value ?? 0))
        case let .removeNotification(notificationId):
            params.append(notificationId)
        case let .readNotification(notificationId):
            params.append(notificationId)
        case let .getBrandInfoById(brandId):
            params.append(UserDefaults.currentArea?.id.value?.description ?? "0")
            params.append(brandId)
            params.append(Config.language)
        case let .getBrandLocationsByAreaId(areaId, brandId):
            params.append(areaId)
            params.append(brandId)
            params.append(Config.language)
        case .getBrandFilterationList:
            params.append(Config.language)
        case let .getBrandsNotificationsCount(brandId):
            params.append(String(brandId))
        case let .getBrandBranchList(brandId):
              params.append(String(brandId))
              params.append(Config.language)
        case let .getBrandPaymentData(areaId, brandId):
            params.append(areaId)
            params.append(String(brandId))
            params.append(Config.language)
        case let .getMyFatoorahBrandPaymentData(areaId, brandId):
            params.append(areaId)
            params.append(String(brandId))
            params.append(Config.language)
        default: break
        }
        return params
    }
    internal var urlQueryParameters: [[String : String]]?{
        var params = [[String : String]]()
        switch self {
        case let .getBrandList(requestBrandDTO):
            params.append(["brandsMe" : "\(requestBrandDTO.brandsMe.value ?? 0)"])
            params.append(["areaID" : "\(requestBrandDTO.areaID.value ?? 0)"])
            params.append(["feedMe" : "\(requestBrandDTO.feedMe.value ?? "")"])
            params.append(["cusineIDs" : "\(requestBrandDTO.cusineIDs.value ?? "")"])
            params.append(["serviceIDs" : "\(requestBrandDTO.serviceIDs.value ?? "")"])
            params.append(["facilityIDs" : "\(requestBrandDTO.facilityIDs.value ?? "")"])
            params.append(["sortID" : "\(requestBrandDTO.sortID.value ?? "")"])
            params.append(["lang" : "\(requestBrandDTO.lang.value ?? "")"])
            params.append(["pageIndex" : "\(requestBrandDTO.pageIndex.value ?? "")"])
            params.append(["pageSize" : "\(requestBrandDTO.pageSize.value ?? "")"])
            if let brandName = requestBrandDTO.brandName.value, brandName != "" {
                params.append(["brandName" : "\(brandName)"])
            }

        default:break
        }
        return params
    }
    // MARK: - Methods
    internal var method: HTTPMethod {
        switch self {
        case .getAdList,.getBranchsNearBy,.getBrandNotifications,.getBrandsNotifications,.removeNotification,.readNotification,.getBrandInfoById,.getBrandLocationsByAreaId,.getBrandList,.getBrandFilterationList,.getBrandsNotificationsCount,.getBrandBranchList,.getBrandPaymentData,.getMyFatoorahBrandPaymentData:
            return .get
        default :
            return .post
        }
    }
}
