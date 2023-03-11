//
//  Network.swift
//  Netwroking
//
//  Created by SimpleTouch on 9/22/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
public class NetworkBLL: NetworkingBLL {
    public init() {}
    /*
    var alamoFireManager : SessionManager?
    
    private lazy var backgroundManager: Alamofire.SessionManager = {
            let bundleIdentifier = "com.simpletouch.Rosto"
            return Alamofire.SessionManager(configuration: URLSessionConfiguration.background(withIdentifier: bundleIdentifier + ".background"))
        }()

   public var backgroundCompletionHandler: (() -> Void)? {
        get {
            return backgroundManager.backgroundCompletionHandler
        }
        set {
            backgroundManager.backgroundCompletionHandler = newValue
        }
    }

    */
    public func sendRequest2(_ apiRoute: URLRequestBuilderBLL, completion: @escaping onResponse) {
        /*
        backgroundManager.session.configuration.shouldUseExtendedBackgroundIdleMode = true
        backgroundManager.startRequestsImmediately = true
        backgroundManager.session.configuration.timeoutIntervalForRequest = 180

        backgroundManager.request(apiRoute.requestURL, method: apiRoute.method, parameters: apiRoute.parameters, encoding: apiRoute.encoding, headers: apiRoute.headers)
                  .responseJSON { (response) in
                      //                guard self != nil else { return }
                      switch response.result {
                      case .success( _):
                          guard let data = response.data else {
                              completion(nil,NetworkError.IncorrectDataReturned )
                              return
                          }
                          guard let json = try? JSON(data: data) else {                         completion(nil,NetworkError.IncorrectDataReturned)
                              return
                          }
                          //                    let decoder = JSONDecoder()
                          //                    let object = try! decoder.decode(type, from: data)
                          print("LOG -> \(apiRoute.requestURL.absoluteString)")
                          print("WITH PARAMS -> \(String(describing: apiRoute.parameters?.jsonString()))")
                          print("BACKEND RESPONSE Status =  \(response.response?.statusCode) WITH JSON = \(json)")
                          
                          completion(MainResponse(statusCode: response.response?.statusCode, json: json) , nil)
                      case .failure(let error):
                          completion(nil,NetworkError(error: error as NSError))
                      }
              }
*/
    }
    public func sendRequest(_ apiRoute: URLRequestBuilderBLL, completion: @escaping  onResponse) {
        //       try? Alamofire.request(apiRoute.asURLRequest())
        print("LOG -> TRY CaLLING  \(apiRoute.requestURL.absoluteString)")
        print("WITH PARAMS -> \(String(describing: apiRoute.parameters?.jsonString()))")
//         mohamed
        print("WITH Headers -> \(String(describing: apiRoute.headers.jsonString()))")
//         mohamed
        Alamofire.request(apiRoute.requestURL, method: apiRoute.method, parameters: apiRoute.parameters, encoding: apiRoute.encoding, headers: apiRoute.headers)
            .responseJSON { [weak self] (response) in
                //                guard self != nil else { return }
                switch response.result {
                case .success( _):
                    guard let data = response.data else {
                        completion(nil,NetworkErrorBLL.IncorrectDataReturned )
                        return
                    }
                    guard let json = try? JSON(data: data) else {                         completion(nil,NetworkErrorBLL.IncorrectDataReturned)
                        return
                    }
                    //                    let decoder = JSONDecoder()
                    //                    let object = try! decoder.decode(type, from: data)
                    print("LOG -> \(apiRoute.requestURL.absoluteString)")
                    print("WITH PARAMS -> \(String(describing: apiRoute.parameters?.jsonString()))")
                    print("BACKEND RESPONSE Status =  \(response.response?.statusCode) WITH JSON = \(json)")
                    
                    completion(MainResponseBLL(statusCode: response.response?.statusCode, json: json) , nil)
                case .failure(let error):
                    print("LOG -> \(apiRoute.requestURL.absoluteString)")
                    print("WITH PARAMS -> \(String(describing: apiRoute.parameters?.jsonString()).replacingOccurrences(of: "\\", with: ""))")
                    print("BACKEND RESPONSE FAILED With Error =  \(error.localizedDescription)")
                    completion(nil,NetworkErrorBLL(error: error as NSError))
                }
        }
    }
    func sendRequest<T>(_ apiRoute: URLRequestBuilderBLL) -> T{
        print("sdf")
        return 4 as! T
    }
    public func sendRequest3(_ apiRoute: URLRequestBuilderBLL, completion: @escaping  onResponse) {
        var request = URLRequest(url: apiRoute.requestURL)
        request.httpMethod = apiRoute.method.rawValue
        for header in apiRoute.headers {
            // mohamed
            request.setValue(header.key, forHTTPHeaderField: header.value)
        }
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                completion(nil,NetworkErrorBLL(error: error as NSError))
                return
            }
            print(response!)
               do {
                   let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                   print(json)
               } catch {
                   print("error")
               }
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Error with the response, unexpected status code: \(response)")
                return
            }
            guard let data = data else {
                completion(nil,NetworkErrorBLL.IncorrectDataReturned )
                return
            }
            let x = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
            guard let json = try? JSON(data: data) else {                         completion(nil,NetworkErrorBLL.IncorrectDataReturned)
                return
            }
            //                    let decoder = JSONDecoder()
            //                    let object = try! decoder.decode(type, from: data)
            print("LOG -> \(apiRoute.requestURL.absoluteString)")
            print("WITH PARAMS -> \(String(describing: apiRoute.parameters?.jsonString()))")
            print("BACKEND RESPONSE Status =  \(httpResponse.statusCode) WITH JSON = \(json)")
            
            completion(MainResponseBLL(statusCode: httpResponse.statusCode, json: json) , nil)
        })
        task.resume()
    }
}
