//
//  STTextField+Extensions.swift
//  STDobites
//
//  Created by SimpleTouch on 10/7/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
extension UITextField {

    func underlineTextField(_ color : UIColor){
        let bottomLine = CALayer()

        if LocalizationSystem.sharedInstance.isCurrentLanguageArabic() {
            bottomLine.frame = CGRect(origin: CGPoint(x: 20, y:self.frame.height - 1), size: CGSize(width: self.frame.width - 60 , height:  1))

        }else{
            bottomLine.frame = CGRect(origin: CGPoint(x: 0, y:self.frame.height - 1), size: CGSize(width: self.frame.width - 30, height:  1))

        }
        bottomLine.backgroundColor = color.cgColor
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
    }
    func datePicker(_ doneBlock: Selector){
        let  datePicker =  UIDatePicker()

        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        toolbar.barStyle = .default
        toolbar.isTranslucent = false
        toolbar.tintColor = UIColor(red: 230/255, green: 45/255, blue: 40/255, alpha: 1)
        
        
        let doneButton = UIBarButtonItem(title: "done".localized(), style: .plain, target: self, action:doneBlock);
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "cancel".localized(), style: .plain, target: self, action:#selector(onCancelTapped(_:)));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        self.inputAccessoryView = toolbar
        self.inputView = datePicker
        
    }
    @objc func onCancelTapped( _: UIBarButtonItem) {
        self.endEditing(true)
    }
   
}
extension UITextField {
    open override func awakeFromNib() {
        super.awakeFromNib()
        let lang : String  = LocalizationSystem.sharedInstance.getLanguage()
        if lang == "ar" {
            if textAlignment == .natural {
                self.textAlignment = .right
            } else {
                self.textAlignment = .natural
            }
        }
    }
    /// SwifterSwift: Add padding to the left of the textfield rect.
    ///
    /// - Parameter padding: amount of padding to apply to the left of the textfield rect.
    func addPaddingRight(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
        rightView = paddingView
        rightViewMode = .always
    }
}
//MARK: - Credit Card
extension UITextField {
    // Creadit card Number Functions
    func removeNonDigits(string: String, andPreserveCursorPosition cursorPosition: inout Int) -> String {
        var digitsOnlyString = ""
        let originalCursorPosition = cursorPosition

        for i in Swift.stride(from: 0, to: string.count, by: 1) {
            let characterToAdd = string[string.index(string.startIndex, offsetBy: i)]
            if characterToAdd >= "0" && characterToAdd <= "9" {
                digitsOnlyString.append(characterToAdd)
            }
            else if i < originalCursorPosition {
                cursorPosition -= 1
            }
        }

        return digitsOnlyString
    }

    func insertCreditCardSpaces(_ string: String, preserveCursorPosition cursorPosition: inout Int) -> String {
        // Mapping of card prefix to pattern is taken from
        // https://baymard.com/checkout-usability/credit-card-patterns

        // UATP cards have 4-5-6 (XXXX-XXXXX-XXXXXX) format
        let is456 = string.hasPrefix("1")

        // These prefixes reliably indicate either a 4-6-5 or 4-6-4 card. We treat all these
        // as 4-6-5-4 to err on the side of always letting the user type more digits.
        let is465 = [
            // Amex
            "34", "37",

            // Diners Club
            "300", "301", "302", "303", "304", "305", "309", "36", "38", "39"
        ].contains { string.hasPrefix($0) }

        // In all other cases, assume 4-4-4-4-3.
        // This won't always be correct; for instance, Maestro has 4-4-5 cards according
        // to https://baymard.com/checkout-usability/credit-card-patterns, but I don't
        // know what prefixes identify particular formats.
        let is4444 = !(is456 || is465)

        var stringWithAddedSpaces = ""
        let cursorPositionInSpacelessString = cursorPosition

        for i in 0..<string.count {
            let needs465Spacing = (is465 && (i == 4 || i == 10 || i == 15))
            let needs456Spacing = (is456 && (i == 4 || i == 9 || i == 15))
            let needs4444Spacing = (is4444 && i > 0 && (i % 4) == 0)

            if needs465Spacing || needs456Spacing || needs4444Spacing {
                stringWithAddedSpaces.append(" ")

                if i < cursorPositionInSpacelessString {
                    cursorPosition += 1
                }
            }

            let characterToAdd = string[string.index(string.startIndex, offsetBy:i)]
            stringWithAddedSpaces.append(characterToAdd)
        }

        return stringWithAddedSpaces
    }
    // Credit Card Expiry Dare formate
    func expDateValidation(dateStr:String) {

        let currentYear = Calendar.current.component(.year, from: Date()) % 100   // This will give you current year (i.e. if 2019 then it will be 19)
        let currentMonth = Calendar.current.component(.month, from: Date()) // This will give you current month (i.e if June then it will be 6)

        let enteredYear = Int(dateStr.suffix(2)) ?? 0 // get last two digit from entered string as year
        let enteredMonth = Int(dateStr.prefix(2)) ?? 0 // get first two digit from entered string as month
        print(dateStr) // This is MM/YY Entered by user

        if enteredYear > currentYear {
            if (1 ... 12).contains(enteredMonth) {
                print("Entered Date Is Right")
            } else {
                print("Entered Date Is Wrong")
            }
        } else if currentYear == enteredYear {
            if enteredMonth >= currentMonth {
                if (1 ... 12).contains(enteredMonth) {
                   print("Entered Date Is Right")
                } else {
                   print("Entered Date Is Wrong")
                }
            } else {
                print("Entered Date Is Wrong")
            }
        } else {
           print("Entered Date Is Wrong")
        }

    }
   

}
private var __maxLengths = [UITextField: Int]()
extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        if let t = textField.text {
            textField.text = String(t.prefix(maxLength))
        }
    }
}
