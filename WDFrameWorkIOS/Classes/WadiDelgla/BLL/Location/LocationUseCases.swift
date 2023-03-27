//
//  LocationUseCases.swift
//  BLL
//
//  Created by SimpleTouch on 10/24/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Alamofire
import Network
////import DAL
//import SwiftyJSON
public class LocationUseCasesBLL : LocationServiceBLL  {
   
    
    
    private var network: NetworkingBLL
    public init(network : NetworkingBLL){
        self.network = network
    }
    /// This Function to get cities and areas for brand Id
    ///
    /// - Parameters:
    ///   - brandId: brand Id
    ///   - lang: current app Language
    ///   - completion: it returns cities and areas
    public func getCitiesAndAreas(withBrandId brandId: Int,forLang lang: String,completion: @escaping onSuccessBLL) {
        //API
        let request = LocationRoute.getCityAndAreas(language: lang, brandId: brandId)
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
                let cities =  json.map({try! CityDTODAL.init(json: $0)})
                completion(STResponseBLL(data: cities, error:nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
}
