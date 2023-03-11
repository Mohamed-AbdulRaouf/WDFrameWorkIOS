//
//  IReferralCodeValidationManager.swift
//  BLL
//
//  Created by Nermeen Mohamed on 10/30/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Foundation
////import DAL
public protocol IReferralCodeValidationManagerBLL  {
    var errorViewModel: IRefferalCodeValidationDTOBLL? { get set }
    func validateReferralCode(string: String) -> Bool
}
extension IReferralCodeValidationManagerBLL where Self: IValidationManagerBLL {
    
    public typealias T = String
    
    public typealias M = IRefferalCodeValidationDTOBLL 
    public func validate(model: String) -> Bool {
        fatalError("Must override this function")
    }
}
