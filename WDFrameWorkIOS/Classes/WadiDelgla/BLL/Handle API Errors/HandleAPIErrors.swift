//
//  HandleAPIErrors.swift
//  BLL
//
//  Created by SimpleTouch on 3/16/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
class HandleAPIErrorsBLL : IHandleAPIErrorsBLL{
   static func handleError(errorCode: Int) -> String {
    if APIErrorsBLL.contains(where: {$0.code.value == errorCode}) {
            // it exists, do something
        if let error = APIErrorsBLL.first(where: {$0.code.value == errorCode}) {
                // do something with foo
            return Config.language == "en" ? error.error_en.value! : error.error_ar.value!
             }
         } else {
            //item could not be found
        return RBLL.string.localizable.error_occure()
         }
    return RBLL.string.localizable.error_occure()
    }
    
    
}
