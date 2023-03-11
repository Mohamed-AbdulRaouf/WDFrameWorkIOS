//
//  MenuUseCases.swift
//  BLL
//
//  Created by SimpleTouch on 11/13/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Alamofire
import Network
////import DAL

public class  MenuUseCasesBLL : MenuServiceBLL  {
   
    private var network: NetworkingBLL
    public init(network : NetworkingBLL){
        self.network = network
    }
    /// This Function to get category List and items for each category
    ///
    /// - Parameters:
    ///   - requestcategoryListDTO: get category list for specific area and brand
    ///   - completion: this returns category list
    public func getMenuItems(_ requestcategoryListDTO: IRequestCategoryListDTODAL, completion: @escaping onSuccessBLL) {
        //API
        let request = MenuRouteBLL.getMenuItems(requestCategoryListDTO: requestcategoryListDTO)
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
                let menuItems =  json.map({try! CategoryMenuItemsDTODAL.init(json: $0)})
                completion(STResponseBLL(data: menuItems, error:nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
    public func getMenuCategoryList(_ requestcategoryListDTO: IRequestCategoryListDTODAL, completion: @escaping onSuccessBLL) {
           //API
           let request = MenuRouteBLL.getMenuCategoryList(requestCategoryListDTO: requestcategoryListDTO)
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
                   let categories =  json.map({try! CategoryMenuItemsDTODAL.init(json: $0)})
                   completion(STResponseBLL(data: categories, error:nil))
               }else {
                   completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
               }
           }
       }
}
