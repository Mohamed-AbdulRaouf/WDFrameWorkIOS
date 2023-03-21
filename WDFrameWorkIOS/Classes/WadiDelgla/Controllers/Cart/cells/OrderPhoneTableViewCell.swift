//
//  OrderPhoneTableViewCell.swift
//  WDFrameWorkIOS
//
//  Created by Raouf on 20/03/2023.
//

import UIKit

class OrderPhoneTableViewCell: UITableViewCell {
    
    @IBOutlet weak var phoneTextView: UITextView!
    var onChangePhone : ((String) -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func configureCell(_ phone: String){
        if K.shared.APP_LANGUAGE == SupportedLanguage.Arabic.rawValue {
            phoneTextView.textAlignment = .right
        }
        phoneTextView.delegate = self
        phoneTextView.backgroundColor = .white
        phoneTextView.layer.borderColor = UIColor.lightGray.cgColor
        phoneTextView.layer.borderWidth = 1
        phoneTextView.text = phone.replacingOccurrences(of: " ", with: "") == "" ? "Enter your phone number".localized() : phone
        phoneTextView.textColor = phone.replacingOccurrences(of: " ", with: "") == "" ? UIColor.lightGray : .black
        phoneTextView.selectedTextRange = phoneTextView.textRange(from: phoneTextView.beginningOfDocument, to: phoneTextView.beginningOfDocument)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
extension OrderPhoneTableViewCell: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        let phone = textView.text == "Enter your phone number".localized() ? "" : textView.text
        onChangePhone!(phone!)
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
       
        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {
            
            textView.text = "Enter your phone number".localized()
            textView.textColor = UIColor.lightGray
            
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }
            
            // Else if the text view's placeholder is showing and the
            // length of the replacement string is greater than 0, set
            // the text color to black then set its text to the
            // replacement string
        else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.textColor = UIColor.black
            textView.text = text
        }
            
            // For every other case, the text should change with the usual
            // behavior...
        else {
            return true
        }
        
        // ...otherwise return false since the updates have already
        // been made
        return false
    }
}
