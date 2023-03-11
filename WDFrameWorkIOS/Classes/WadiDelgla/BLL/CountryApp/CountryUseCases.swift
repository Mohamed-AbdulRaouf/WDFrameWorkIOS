//
//  CountryUseCases.swift
//  BLL
//
//  Created by SimpleTouch on 11/15/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
import Alamofire
import Network
////import DAL

public class  CountryUseCasesBLL : CountryServiceBLL  {
    
    
    
    
    private var network: NetworkingBLL
    public init(network : NetworkingBLL){
        self.network = network
    }
    /// This Function to get All Available Countries
       ///
       /// - Parameters:
       ///   - completion: this returns All Countries
    public func getAllAvailableCountries(completion: @escaping onSuccessBLL) {
        //API
        let request = CountryRouteBLL.getAllAvailableCountries
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
                let countryList =  json.map({try! CountryDTODAL.init(json: $0)})
                completion(STResponseBLL(data: countryList, error:nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
    /// This Function to get Available Country  List for specific brand
       ///
       /// - Parameters:
       ///   - completion: this returns brand's available Country list
    public func getBrandAvailableCountries(_ brandId: Int, completion: @escaping onSuccessBLL) {
        //API
              let request = CountryRouteBLL.getBrandAvailableCountries(brandId: brandId)
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
                      let countryList =  json.map({try! CountryDTODAL.init(json: $0)})
                      completion(STResponseBLL(data: countryList, error:nil))
                  }else {
                      completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
                  }
              }
    }
}
