//
//  BrandUseCases.swift
//  BLL
//
//  Created by Nermeen Mohamed on 10/28/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Alamofire
import Network
////import DAL

public class  BrandUseCasesBLL : BrandServiceBLL  {
    
    private var network: NetworkingBLL
    public init(network : NetworkingBLL){
        self.network = network
    }
    
    /// This Function to get Ads List
    ///
    /// - Parameters:
    ///   - pagingDTO: paging model
    ///   - completion: this returns ads list
    public func getAdsList(pagingDTO:IPagingDTODAL,completion: @escaping onSuccessBLL) {
        //API
        let request = BrandRouteBLL.getAdList(pagingDTO: pagingDTO)
        network.sendRequest(request) { (response, error) in
            guard error == nil else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                return
            }
            if response?.statusCode == 200 && response?.messageCode == 601 {
                guard let json = response?.data?.arrayValue else {
                    completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: StandardMessagesBLL.faildParseJson)))
                    return
                }
                let ads =  json.map({try! AdsDTODAL.init(json: $0)})
                completion(STResponseBLL(data: ads, error:nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
    
    /// This Function to get the nearest Resturants
    ///
    /// - Parameters:
    ///   - lat: Lantitude of Location
    ///   - long: Longitute of Location
    ///   - completion: This returns the nearest Resturants for specific location
    public func getBranchsNearBy(_ lat: Double,_ long: Double,completion: @escaping onSuccessBLL){
        //API
        let request = BrandRouteBLL.getBranchsNearBy(lat: lat, long: long)
        network.sendRequest(request) { (response, error) in
            guard error == nil else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                return
            }
            if response?.statusCode == 200 && response?.messageCode == 601 {
                guard let json = response?.data?.arrayValue else {
                    completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: StandardMessagesBLL.faildParseJson)))
                    return
                }
                let brandLocations =  json.map({try! BrandLocationDTODAL.init(json: $0)})
                completion(STResponseBLL(data: brandLocations, error:nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
    /// This Function to get the Brands' Notifications
    ///
    /// - Parameters:
    ///   - requestNotificationDTO: request notifications model
    ///   - completion: this returns the notification list for  brands
    public func getBrandsNotifications(_ requestNotificationDTO: IRequestDTODAL, completion: @escaping onSuccessBLL) {
        //API
        let request = BrandRouteBLL.getBrandsNotifications(requestDTO: requestNotificationDTO)
        network.sendRequest(request) { (response, error) in
            guard error == nil else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                return
            }
            if response?.statusCode == 200 && response?.messageCode == 601 {
                guard let json = response?.data?.arrayValue else {
                    completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: StandardMessagesBLL.faildParseJson)))
                    return
                }
                let notifications =  json.map({try! NotificationDTODAL.init(json: $0)})
                completion(STResponseBLL(data: notifications, error:nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
    /// This Function to get the brand's Notification List
    ///
    /// - Parameters:
    ///   - requestNotificationDTO: request notifications model
    ///   - completion:  this returns the notification list for brand
    public func getBrandNotifications(_ requestNotificationDTO: IRequestDTODAL, completion: @escaping onSuccessBLL) {
        //API
        let request = BrandRouteBLL.getBrandNotifications(requestDTO: requestNotificationDTO)
        network.sendRequest(request) { (response, error) in
            guard error == nil else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                return
            }
            if response?.statusCode == 200 && response?.messageCode == 601 {
                guard let json = response?.data?.arrayValue else {
                    completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: StandardMessagesBLL.faildParseJson)))
                    return
                }
                let notifications =  json.map({try! NotificationDTODAL.init(json: $0)})
                completion(STResponseBLL(data: notifications, error:nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
    /// This Function to remove notifiaction
    ///
    /// - Parameters:
    ///   - notificationId: notification id to be removed
    ///   - completion: This returns success or fail removed notification
    public func removeNotification(_ notificationId: String, completion: @escaping onSuccessBLL) {
        //API
        let request = BrandRouteBLL.removeNotification(notificationId: notificationId)
        network.sendRequest(request) { (response, error) in
            guard error == nil else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                return
            }
            if response?.statusCode == 200 && response?.messageCode == 601 {
                completion(STResponseBLL(data: true, error:nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
    /// This Function to make notification be readed
    ///
    /// - Parameters:
    ///   - notificationId: notification Id
    ///   - completion: This returns success or fail marked notification as readed
    public func readNotification(_ notificationId: String, completion: @escaping onSuccessBLL) {
        //API
        let request = BrandRouteBLL.readNotification(notificationId: notificationId)
        network.sendRequest(request) { (response, error) in
            guard error == nil else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                return
            }
            if response?.statusCode == 200 && response?.messageCode == 601 {
                completion(STResponseBLL(data: true, error:nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
    /// This function to get brand info by given brand id
    ///
    /// - Parameters:
    ///   - brandId: Brand Info
    ///   - completion: This returns brand info details
    public func getBrandInfoById(_ brandId: String,completion: @escaping onSuccessBLL){
        //API
        let request = BrandRouteBLL.getBrandInfoById(brandId: brandId)
        network.sendRequest(request) { (response, error) in
            guard error == nil else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                return
            }
            if response?.statusCode == 200 && response?.messageCode == 601 {
                guard let json = response?.data else {
                    completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: StandardMessagesBLL.faildParseJson)))
                    return
                }
                let brand = BrandDTODAL(json: json)
                completion(STResponseBLL(data: brand, error:nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
    /// This Function to get brand Locations by given area Id
    ///
    /// - Parameters:
    ///   - areaId: area Id
    ///   - brandId: brand Id
    ///   - completion: this returns brand's Locations
    public func getBrandLocationsByAreaId(_ areaId: String, brandId: String, completion: @escaping onSuccessBLL) {
        //API
        let request = BrandRouteBLL.getBrandLocationsByAreaId(areaId: areaId, brandId: brandId)
        network.sendRequest(request) { (response, error) in
            guard error == nil else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                return
            }
            if response?.statusCode == 200 && response?.messageCode == 601 {
                guard let json = response?.data?.arrayValue else {
                    completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: StandardMessagesBLL.faildParseJson)))
                    return
                }
                let brandLocations =  json.map({try! BrandLocationDTODAL.init(json: $0)})
                completion(STResponseBLL(data: brandLocations, error:nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
    /// This Function to get brand List in specific criteria
    ///
    /// - Parameters:
    ///   - requestBrandDTO: request brand list model such as cusinies , facilityIDs ..etc
    ///   - completion: This returns brand List
    public func getBrandList(_ requestBrandDTO: IRequestBrandDTODAL, completion: @escaping onSuccessBLL) {
        //API
        let request = BrandRouteBLL.getBrandList(requestBrandDTO: requestBrandDTO)
        network.sendRequest(request) { (response, error) in
            guard error == nil else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                return
            }
            if response?.statusCode == 200 && response?.messageCode == 601 {
                guard let json = response?.data else {
                    completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: StandardMessagesBLL.faildParseJson)))
                    return
                }
                let brands =  try! BrandListDTODAL.init(forBrandListjson: json)
                completion(STResponseBLL(data: brands, error:nil))

            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
    /// This Function to get the filterations and services list
    ///
    /// - Parameter completion: This returns the filterations and services list
    public func getBrandFilterationAndServicesList(completion: @escaping onSuccessBLL) {
        //API
        let request = BrandRouteBLL.getBrandFilterationList
        network.sendRequest(request) { (response, error) in
            guard error == nil else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                return
            }
            if response?.statusCode == 200 && response?.messageCode == 601 {
                guard let json = response?.data else {
                    completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: StandardMessagesBLL.faildParseJson)))
                    return
                }
                let brands =  try! FilterationListDTODAL.init(json: json)
                completion(STResponseBLL(data: brands, error:nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
    /// This Function to get not reated notification count
    ///
    /// - Parameters:
    ///   - brandId: brand Id
    ///   - completion: This returns the count of not readed notifications
    public func getBrandsNotificationsCount(_ brandId: Int,completion: @escaping onSuccessBLL) {
        //API
        let request = BrandRouteBLL.getBrandsNotificationsCount(brandId: brandId)
        network.sendRequest(request) { (response, error) in
            guard error == nil else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                return
            }
            if response?.statusCode == 200 && response?.messageCode == 601 {
                guard let count = response?.data?.intValue else {
                    completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: StandardMessagesBLL.faildParseJson)))
                    return
                }
                
                completion(STResponseBLL(data: count, error:nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
    /// This Function to get brand's branch List
       ///
       /// - Parameters:
       ///   - brandId: brand Id
       ///   - completion: This returns the count of not readed notifications
    public func getBrandBranchList(_ brandId: Int, completion: @escaping onSuccessBLL) {
              //API
              let request = BrandRouteBLL.getBrandBranchList(brandId: brandId)
              network.sendRequest(request) { (response, error) in
                  guard error == nil else {
                      completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                      return
                  }
                  if response?.statusCode == 200 && response?.messageCode == 601 {
                      guard let json = response?.data?.arrayValue else {
                          completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: StandardMessagesBLL.faildParseJson)))
                          return
                      }
                      let branches =  json.map({try! BranchDTODAL.init(json: $0)})
                      completion(STResponseBLL(data: branches, error:nil))
                  }else {
                      completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
                  }
              }
    }
    /// This Function to get the Brand Payment Data
       ///
     /// -
       /// - Parameter completion: This returns the filterations and services list
    public func getBrandPaymentData(_ areaId: String, _ brandId: Int, completion: @escaping onSuccessBLL) {
           //API
           let request = BrandRouteBLL.getBrandPaymentData(areaId: areaId, brandId: brandId)
           network.sendRequest(request) { (response, error) in
               guard error == nil else {
                   completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                   return
               }
               if response?.statusCode == 200 && response?.messageCode == 601 {
                   guard let json = response?.data else {
                       completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: StandardMessagesBLL.faildParseJson)))
                       return
                   }
                   let brandPaymentDTO = BrandPaymentDataDTODAL(json: json)
                UserDefaults.brandPaymentData = brandPaymentDTO
                   completion(STResponseBLL(data: brandPaymentDTO, error:nil))
               }else {
                   completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
               }
           }
       }
    /// This Function to get My Fatoorah  Brand Payment Data
       ///
     /// -
       /// - Parameter completion: This returns the filterations and services list
    public func getMyFatoorahBrandPaymentData(_ areaId: String, _ brandId: Int, completion: @escaping onSuccessBLL) {
           //API
           let request = BrandRouteBLL.getMyFatoorahBrandPaymentData(areaId: areaId, brandId: brandId)
           network.sendRequest(request) { (response, error) in
               guard error == nil else {
                   completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                   return
               }
               if response?.statusCode == 200 && response?.messageCode == 601 {
                   guard let json = response?.data else {
                       completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: StandardMessagesBLL.faildParseJson)))
                       return
                   }
                   let brandPaymentDTO = MyFatoorahBrandPaymentDataDTODAL(json: json)
                UserDefaults.myFatoorahBrandPaymentData = brandPaymentDTO
                   completion(STResponseBLL(data: brandPaymentDTO, error:nil))
               }else {
                   completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
               }
           }
       }
}
