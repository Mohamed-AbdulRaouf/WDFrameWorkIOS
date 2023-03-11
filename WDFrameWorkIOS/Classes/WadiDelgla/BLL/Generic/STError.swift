//
//  STError.swift
//  BLL
//
//  Created by SimpleTouch on 10/10/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
//import Firebase
public class STErrorBLL {
    public var validateError : IBaseValidationDTOBLL?
    public var APIError : StandardMessagesBLL?
    public var networkError : NetworkErrorBLL?
    public var FireBaseError: String?
    public var KashierError: String?
    public var ErrorCode : Int?
    
    init(validateError : IBaseValidationDTOBLL?,APIError : StandardMessagesBLL?,networkError:NetworkErrorBLL? = nil,firebaseError:String? = nil,ErrorCode: Int? = nil,KashierError: String? = nil){
        self.validateError = validateError
        self.APIError = APIError
        self.networkError = networkError
        self.FireBaseError = firebaseError
        self.ErrorCode = ErrorCode
        self.KashierError = KashierError
    }
}
