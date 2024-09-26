//
//  STString+Extensions.swift
//  BLL
//
//  Created by SimpleTouch on 10/2/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
extension String {
    /// This Function To validate email for given string
    ///
    /// - Returns: it returns true is valid to email expression
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
    
    var isValidPhone: Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: self)
    }
    
    
}
extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    func isExpiryDate() -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/yy"
        let cardExpiryMonth   = self.substring(toIndex: 2)
        let cardExpiryYear   = self.substring(fromIndex: 2)
        let expiryDate = cardExpiryMonth + "/" + cardExpiryYear
        guard let enteredDate = dateFormatter.date(from: expiryDate) else {
          return false
        }
        let endOfMonth = Calendar.current.date(byAdding: .month, value: 1, to: enteredDate)!
        let now = Date()
        if (endOfMonth < now) {
            print("Expired - \(enteredDate) - \(endOfMonth)")
            return false
        }
        return true
    }

    var getPhoneNumberOnlyWithCountry: String {
        return self.replacingOccurrences(of: "+2", with: "")
    }
}
