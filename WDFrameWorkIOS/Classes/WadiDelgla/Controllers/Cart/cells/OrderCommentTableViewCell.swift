//
//  OrderCommentTableViewCell.swift
//  HamamAbdo
//
//  Created by SimpleTouch on 7/20/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import UIKit

class OrderCommentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var commentTextView: UITextView!
    var onChangeComment : ((String) -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func configureCell(_ comment: String){
        if LocalizationSystem.sharedInstance.isCurrentLanguageArabic() {
            commentTextView.textAlignment = .right
        }
        commentTextView.delegate = self
        commentTextView.backgroundColor = .white
        commentTextView.layer.borderColor = UIColor.lightGray.cgColor
        commentTextView.layer.borderWidth = 1
        commentTextView.text = comment.replacingOccurrences(of: " ", with: "") == "" ? "order_comment_description".localized() : comment
        commentTextView.textColor = comment.replacingOccurrences(of: " ", with: "") == "" ? UIColor.lightGray : .black
        commentTextView.selectedTextRange = commentTextView.textRange(from: commentTextView.beginningOfDocument, to: commentTextView.beginningOfDocument)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
extension OrderCommentTableViewCell: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        let comment = textView.text == "order_comment_description".localized() ? "" : textView.text
               onChangeComment!(comment!)
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
       
        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {
            
            textView.text = "order_comment_description".localized()
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
