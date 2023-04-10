//
//  STUIDate+Extensions.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 11/2/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
extension Date{
   static  func convertDate(_ dateFormateToConvertFrom: String,_ convertorderDate: String,_ dateFormateToConvertTo: String) ->String{
        var result = ""
        // create dateFormatter with UTC time format
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormateToConvertFrom
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?

        var orderDate = convertorderDate
        if let dotRange = orderDate.range(of: ".") {
            orderDate.removeSubrange(dotRange.lowerBound..<orderDate.endIndex)
            
            if  let date = dateFormatter.date(from: orderDate)  {
                // change to a readable time format and change to local time zone
                dateFormatter.dateFormat = dateFormateToConvertTo
                dateFormatter.timeZone = NSTimeZone.local
           
                dateFormatter.locale = NSLocale(localeIdentifier: "\(LocalizationSystem.sharedInstance.getLanguage())")
                    as Locale

                
                
                let timeStamp = dateFormatter.string(from: date)
                result = timeStamp
            }else{
                print("There was an error decoding the string")
            }
        }
        return result
    }
    
    private func getDateFormate(_ convertorderDate : String?) -> String{
        var result = ""
        // create dateFormatter with UTC time format
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        var orderDate = convertorderDate ?? ""
        if let dotRange = orderDate.range(of: ".") {
            orderDate.removeSubrange(dotRange.lowerBound..<orderDate.endIndex)
            if  let date = dateFormatter.date(from: orderDate)  {
                // change to a readable time format and change to local time zone
                dateFormatter.dateFormat = "dd MMMM yyyy - hh:mm"
                dateFormatter.timeZone = NSTimeZone.local
                let timeStamp = dateFormatter.string(from: date)
                result = timeStamp
            }else{
                print("There was an error decoding the string")
            }
        }
        return result
    }
}
