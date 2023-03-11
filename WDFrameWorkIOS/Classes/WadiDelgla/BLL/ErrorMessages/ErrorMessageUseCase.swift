//
//  ErrorMessageUseCase.swift
//  BLL
//
//  Created by SimpleTouch on 5/31/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
import Alamofire
import Network
////import DAL

public class  ErrorMessageUseCaseBLL : ErrorMessageServiceBLL  {
    
    
    
    private var network: NetworkingBLL
    public init(network : NetworkingBLL){
        self.network = network
    }
    /// This Function to get Error messages
    ///
    /// - Parameters:
    ///   - completion: this returns error messages
    public func getErrorMessages(completion: @escaping onSuccessBLL) {
        //API
        let request = ErrorMessageRouteBLL.getErrorMessage
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
                let errors_msgs =  json.map({try! CustomErrorDTODAL(json: $0)})
                completion(STResponseBLL(data: errors_msgs, error:nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
}
