//
//  String+Extensions.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 10/29/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
extension String {
    public var arToEnDigits : String {
        let arabicNumbers = ["٠": "0","١": "1","٢": "2","٣": "3","٤": "4","٥": "5","٦": "6","٧": "7","٨": "8","٩": "9"]
        var txt = self
        arabicNumbers.map { txt = txt.replacingOccurrences(of: $0, with: $1)}
        return txt
    }
    public var enToArDigits : String {
        let enNumbers = ["0": "٠","1": "١","2": "٢","3": "٣","4": "٤","5": "٥","6": "٦","7": "٧","8": "٨","9": "٩"]
        var txt = self
        enNumbers.map { txt = txt.replacingOccurrences(of: $0, with: $1)}
        return txt
    }
    func flag() -> String {
        let base = 127397
        var usv = String.UnicodeScalarView()
        for i in self.utf16 {
            usv.append(UnicodeScalar(base + Int(i))!)
        }
        return String(usv)
    }
    
}
