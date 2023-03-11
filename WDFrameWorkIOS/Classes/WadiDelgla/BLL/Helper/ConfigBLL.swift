//
//  Config.swift
//  BLL
//
//  Created by SimpleTouch on 12/30/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

//
//  Config.swift
//  BLL
//
//import Firebase
import Alamofire
////import DAL
import SwiftyJSON
//import FirebaseAuth
//import FirebaseCore
public protocol BLLConfigBLL {
    static var language: String { get }
    static var customerSourceId: Int { get }
    static var fcmToken : String { get }
 }

final class ConfigTypeBLL {
    static fileprivate var shared: ConfigTypeBLL?
    
    var language: String
    var customerSourceId: Int
    var fcmToken: String
    fileprivate init(_ config: BLLConfigBLL.Type) {
        self.language = config.language
        self.customerSourceId = config.customerSourceId
        self.fcmToken = config.fcmToken
     }
}

var APIErrorsBLL: [CustomErrorDTODAL] = []
var ConfigBLL: ConfigTypeBLL { // swiftlint:disable:this variable_name
    if let config = ConfigTypeBLL.shared {
        return config
    } else {
        fatalError("Please set the Config for \(Bundle(for: ConfigTypeBLL.self))")
    }
}

/// Use this method to inject the configuration for this framework.
public func setup(with config: BLLConfigBLL.Type,completion: @escaping () -> ()) {
    // Configure Firebase
    // ------------------
//    if FirebaseApp.app() == nil {
//        FirebaseApp.configure()
//    }
    ConfigTypeBLL.shared = ConfigTypeBLL(config)
    completion()
//    getErrorMessages(completion: completion)
}
public func getErrorMessages(completion: @escaping () -> ()){
        ErrorMessageUseCaseBLL(network: NetworkBLL()).getErrorMessages { (response) in
            guard let data = response?.data else {
                completion()
                return
            }
            if let errorMessagesDTO = data as? [CustomErrorDTODAL] {
                APIErrorsBLL = errorMessagesDTO
                UserDefaults.apiErrors = APIErrorsBLL
            }else{
                if let errors = UserDefaults.apiErrors {
                     APIErrorsBLL = errors
                }
            }
            completion()
    }
}

/*
func setupAPIErrorsFirebaseCache(){
    if !MyFirebaseCacheFile.targetFileExists {
        print("file not Exist so try download it from firebase")
        MyFirebaseCacheFile.startDownload(onComplete: { (url,generation) in
            if let url = url {
                updateGenerationFile(generation)
                APIErrors = CustomFileManager.readFile(url)!
            }
        }) { (error) in
            print(error)
        }
    }else{
        updateLocal(onComplete: { (url) in
            if let url = url {
                APIErrors = CustomFileManager.readFile(url)!
            }
        }) { (error) in
            print(error)
        }
    }
}
func updateLocal(onComplete: @escaping ((URL?) -> Void),
                 onError: @escaping ((_: String?) -> Void)){
    MyFirebaseCacheFile.checkForUpdate(onComplete: { (status: FirebaseStorageCacheableStatus) in
        switch status {
        case .updateAvailable:
            // now would be a great time to trigger the MyCacheableFile.update method here
            MyFirebaseCacheFile.update(onComplete: {
                // the most recent version of the remote file has been downloaded and cached
                print("updated")
                if let filePath = MyFirebaseCacheFile.targetUrl, let contents = try? Data(contentsOf: filePath) {
                    // do your thing
                    print("filePath = \(filePath)")
                    updateGenerationFile()
                    onComplete(filePath)
                }else{
                    // loading failed
                    onError("Error update file")
                }
                
            }, onError: { (error: FirebaseStorageCacheableError?) in
                // handle error
                onError(error?.localizedDescription)
            }, inProgress: { (fractionComplete: Double) in
                // Update UI with download progress (this closure param optional)
            })
            
        case .upToDate:
            // you could display to the user they have up to date information
            print("up to date")
            onComplete(MyFirebaseCacheFile.targetUrl)
            
        }
    }, onError: { (error: FirebaseStorageCacheableError?) in
        // handle error
        onError("Error update file \(error?.localizedDescription)")
    })
}

func updateGenerationFile(_ generation : Int64? = nil){
    guard  generation == nil else {
        UserDefaults.fileGeneration = generation
        return
    }
    MyFirebaseCacheFile.getRemoteModified(onComplete: { (generation) in
        UserDefaults.fileGeneration = generation
    }) { (error) in
        print("Error")
    }
}
*/
