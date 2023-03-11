//
//  ILoginService.swift
//  BLL
//
//  Created by SimpleTouch on 11/22/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
////import DAL
// MARK: -  Interfaces
public protocol ILoginServiceBLL : AnyObject {
    //    associatedtype T
    //    func login(model: T)
    func login(model: ILoginModelDAL,completion: @escaping onSuccessBLL)
}

public class userNameLogin : ILoginServiceBLL {
    
    public typealias T = userNameLoginModelDAL
    
    
    private var network: NetworkBLL
    public init(network : NetworkBLL ){
        self.network = network
        
    }
    
    
    public func login(model: userNameLoginModelDAL) {
        
    }
    public func login(model: ILoginModelDAL,completion: @escaping onSuccessBLL) {
       print("not implemented yet")
        
    }
}

public class userNameCountryLoginBLL : ILoginServiceBLL {
    
    public typealias T = userNameWithCountryLoginModelDAL
    
    private var network: NetworkBLL
      public init(network : NetworkBLL ){
          self.network = network
          
      }
    
    public func login(model: ILoginModelDAL,completion: @escaping onSuccessBLL) {
        let model = model as! IUserNameWithCountryLoginModelDAL
               
               //validate data
               let validationDTO = LoginUNamePassCountryValidationDTOBLL()
        let validation = LoginUserNameCountryValidationManagerBLL(errorModel: validationDTO, hintNumber: model.hintNumber.value)
               
               
               guard validation.validate(model: model) else {
                   completion(STResponseBLL(data: nil, error:STErrorBLL(validateError: validationDTO, APIError: nil)))
                   return
               }
               
               //API
               let request = UserRouteBLL.loginWithCountry(model: model)
               network.sendRequest(request) { (response, error) in
                   guard error == nil else {
                       completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: validationDTO , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                       return
                   }
                   
                   if response?.statusCode == 200 && response?.messageCode == 601 {
                       let user =  UserDTODAL(json: response?.data ?? "")
                       completion(STResponseBLL(data: user, error:nil))
                   }else {
                       completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: validationDTO, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
                   }
               }
    }
}
public enum LoginTypeBLL : Int
{
    case  UserNamePasswordLogin = 1
    case  UserNamePasswordWithExtraCountryLogin = 2
}
// MARK: - Login Factory to Instantiate the proper Login Class
public protocol LoginFactoryBLL {
    func GetLoginService(loginType: LoginTypeBLL) -> ILoginServiceBLL
}
public class ConcreteLoginFactoryBLL : LoginFactoryBLL {
    public func GetLoginService(loginType: LoginTypeBLL) -> ILoginServiceBLL {
        switch loginType {
        case LoginTypeBLL.UserNamePasswordLogin:
            return userNameLogin(network: NetworkBLL())
        case LoginTypeBLL.UserNamePasswordWithExtraCountryLogin:
            return userNameCountryLoginBLL(network: NetworkBLL())
        default:
            print("Login Type \(loginType.rawValue) not supported")
            
        }
    }
}
// MARK: - Login Strategy
public class LoginStrategyBLL {
    private var strategy: ILoginServiceBLL?
    
    private var type: LoginTypeBLL
    /// Usually, the Context accepts a strategy through the constructor, but
    /// also provides a setter to change it at runtime.
    init(type: LoginTypeBLL) {
        self.type = type
    }
    
    /// The Context delegates some work to the Strategy object instead of
    /// implementing multiple versions of the algorithm on its own.
    func login(model: ILoginModelDAL,completion: @escaping onSuccessBLL) {
        print("Context: Sorting data using the strategy (not sure how it'll do it)\n")
        let factory = ConcreteLoginFactoryBLL()
        
        strategy = factory.GetLoginService(loginType: type)
        guard let strategy = strategy else {
            return
        }
        strategy.login(model: model, completion: completion)
    }
}

class userBehaviorBLL {
    var loginBehavior:ILoginServiceBLL?
    var registerBehavior: ILoginServiceBLL?
}
