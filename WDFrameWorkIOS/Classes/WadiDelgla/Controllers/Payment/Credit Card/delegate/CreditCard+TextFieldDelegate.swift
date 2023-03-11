//
//  CreditCard+TextFieldDelegate.swift
//  STDobites
//
//  Created by SimpleTouch on 9/15/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import UIKit
// MARK: - UITextFieldDelegate
extension CreditCardViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.cardNumberTextField {
            previousTextFieldContent = textField.text;
            previousSelection = textField.selectedTextRange;
            return true
        }else if textField == self.cardExpiryDateTextField {
            return setupExpiryDateFormate(textField, shouldChangeCharactersIn: range, replacementString: string)
        }
           return true
       }

       @objc func reformatAsCardNumber(textField: UITextField) {
           var targetCursorPosition = 0
           if let startPosition = textField.selectedTextRange?.start {
               targetCursorPosition = textField.offset(from: textField.beginningOfDocument, to: startPosition)
           }

           var cardNumberWithoutSpaces = ""
           if let text = textField.text {
               cardNumberWithoutSpaces = textField.removeNonDigits(string: text, andPreserveCursorPosition: &targetCursorPosition)
           }

           if cardNumberWithoutSpaces.count > 19 {
               textField.text = previousTextFieldContent
               textField.selectedTextRange = previousSelection
               return
           }

           let cardNumberWithSpaces = textField.insertCreditCardSpaces(cardNumberWithoutSpaces, preserveCursorPosition: &targetCursorPosition)
           textField.text = cardNumberWithSpaces

           if let targetPosition = textField.position(from: textField.beginningOfDocument, offset: targetCursorPosition) {
               textField.selectedTextRange = textField.textRange(from: targetPosition, to: targetPosition)
           }
       }
    
    func setupExpiryDateFormate(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        guard let oldText = textField.text, let r = Range(range, in: oldText) else {
               return true
           }
           let updatedText = oldText.replacingCharacters(in: r, with: string)

           if string == "" {
               if updatedText.count == 2 {
                   textField.text = "\(updatedText.prefix(1))"
                   return false
               }
           } else if updatedText.count == 1 {
               if updatedText > "1" {
                   return false
               }
           } else if updatedText.count == 2 {
               if updatedText <= "12" { //Prevent user to not enter month more than 12
                   textField.text = "\(updatedText)/" //This will add "/" when user enters 2nd digit of month
               }
               return false
           } else if updatedText.count == 5 {
               textField.expDateValidation(dateStr: updatedText)
           } else if updatedText.count > 5 {
               return false
           }

           return true
    }

}
