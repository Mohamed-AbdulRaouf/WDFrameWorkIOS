//
//  Network.swift
//  ProjectMVC
//
//  Created by Mohamed Abdul-Raouf on 05/01/2022.
//

import Alamofire
import Japx

typealias NetworkCompletionPaymob<T> = (AFResultPaymob<T>) -> Void
typealias AFResultPaymob<T> = Result<T, Error>

protocol NetworkProtocolPaymob {
    func request<T>(_ request: URLRequestConvertiblePaymob,
                    decodeTo type: T.Type,
                    completionHandler: @escaping NetworkCompletionPaymob<T>) where T: Codable
    func cancelAllRequests()
    func upload<T>(_ request: URLRequestConvertiblePaymob, data: [UploadData], decodedTo type: T.Type, completionHandler: @escaping NetworkCompletionPaymob<T>) where T: Codable
}

class MainNetworkPaymob: RequestInterceptor {
    
#if DEBUG
    fileprivate let willPrint = true
#else
    fileprivate let willPrint = false
#endif
    
    fileprivate let networkMiddleware = MainNetworkMiddleware()
    
    fileprivate lazy var manager: Session = networkMiddleware.sessionManager
    
    fileprivate func process<T>(response: AFDataResponse<Any>, decodedTo type: T.Type) -> AFResultPaymob<T> where T: Codable {
        switch response.result {
        case .success:
            
            guard let data = response.data else {
                return .failure(NSError.create(description: "Server Error."))
            }
            
//            #if DEBUG
            debugPrint("=======DEBUG========🐰🐰=======NETWORK=====")
            debugPrint("Response URL: \(response.request?.url?.absoluteString ?? "")")
            let json = try? Japx.Decoder.jsonObject(with: data)
            print(JSON(json ?? [:]))
            debugPrint("=======DEBUG========🐰🐰=======NETWORK=====")
//            #endif
            
            do {
                // if convert not transfer successfully , like get notification unread count
                if json == nil {
                    let jsonDecoder = JSONDecoder()
                    let responseModel = try jsonDecoder.decode(T.self, from: data)
                    debugPrint(responseModel)
                    return .success(responseModel)
                }
                let data = try JapxDecoder()
                    .decode(type, from: data)
//                 let data = try JSONDecoder.decodeFromData(type, data: data)
                return .success(data)
            } catch {
                
                #if DEBUG
                debugPrint(error)
                #endif
                
                return .failure(NSError.create(description: "Server Error."))
            }
            
        case .failure(let error):
            
            #if DEBUG
            debugPrint("#DEBUG#", error.localizedDescription)
            #endif
            
            if error.localizedDescription.contains("JSON") {
                return .failure(NSError.create(description: "Server Error."))
            }
            
            return .failure(error)
        }
    }
    
//    fileprivate func process<T>(response: AFDataResponse<Any>, decodedTo type: T.Type) -> AFResult<T> where T: Codable {
//        switch response.result {
//        case .success:
//
//            guard let data = response.data else {
//                if willPrint { debugPrint("=======DEBUG=NETWORK=============Request has no data") }
//                return .failure(NSError.create(description: "server_error"))
//            }
//
//            do {
//                let data = try JapxDecoder().decode(type, from: data)
//                if willPrint {
//                    debugPrint("=======DEBUG=NETWORK=============Request DATA")
//                    dump(data)
//                }
//                return .success(data)
//            } catch {
//                if willPrint {
//                    debugPrint("=======DEBUG=NETWORK=============Request DECODING ERROR")
//                    debugPrint(error)
//                }
//                return .failure(NSError.create(description: "server_error"))
//            }
//
//        case .failure(let error):
//
//            if willPrint {
//                debugPrint("=======DEBUG=NETWORK=============Request Failure")
//                debugPrint(error.localizedDescription)
//            }
//
//            if error.localizedDescription.contains("JSON") {
//                return .failure(NSError.create(description: "server_error"))
//            }
//
//            return .failure(error)
//        }
//    }
    
    func cancelAllRequests() {
        manager.session.getAllTasks { tasks in tasks.forEach { $0.cancel() } }
    }
    
    func upload<T>(_ request: URLRequestConvertiblePaymob, data: [UploadData], decodedTo type: T.Type, completionHandler: @escaping (AFResultPaymob<T>) -> ()) where T: Decodable, T: Encodable {
        
        debugPrint("=======DEBUG=NETWORK=============Request URL")
        debugPrint(request.url.absoluteString as Any)
        
        AF.upload(multipartFormData: { multipart in
            data.forEach {
                multipart.append($0.data, withName: $0.name+"[]", fileName: $0.fileName, mimeType: $0.mimeType)
            }
            
            for (key, value) in request.parameters ?? [:] {
                multipart.append("\(value)".data(using: .utf8)!, withName: key)
            }
            
        }, with: request.urlRequest!)
            .uploadProgress(queue: .main, closure: { progress in
                //Current upload progress of file
                
#if DEBUG
                print(String(format: "%.1f", progress.fractionCompleted * 100))
#endif
                
            })
            .responseJSON(completionHandler: {[weak self] response in
                guard let self = self else { return }
                completionHandler(self.process(response: response, decodedTo: type))
            })
    }
}

extension MainNetworkPaymob: NetworkProtocolPaymob {
    func request<T>(_ request: URLRequestConvertiblePaymob,
                    decodeTo type: T.Type,
                    completionHandler: @escaping (AFResultPaymob<T>) -> Void) where T: Codable {
        manager.request(request).responseJSON {[weak self] response in
            guard let self = self else { return }
            
            if self.willPrint {
                debugPrint("=======DEBUG=NETWORK=============Request URL")
                debugPrint(response.request?.url?.absoluteString as Any)
                debugPrint("=======DEBUG=NETWORK=============Request RESPONSE")
                debugPrint(response)
            }
            
            completionHandler(self.process(response: response, decodedTo: type))
        }
    }
}

fileprivate extension NSError {
    class func create(description: String) -> NSError {
        return NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: description])
    }
}

