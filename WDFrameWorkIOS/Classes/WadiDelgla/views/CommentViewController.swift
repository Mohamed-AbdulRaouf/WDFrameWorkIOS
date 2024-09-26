//
//  CommentViewController.swift
//  KaramElSham
//
//  Created by SimpleTouch on 7/15/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController {
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    var comment : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    func setupUI(){
        commentTextView.delegate = self
        commentTextView.text = comment.replacingOccurrences(of: " ", with: "") == "" ? "comment_description".localized() : comment
        commentTextView.textColor = comment.replacingOccurrences(of: " ", with: "") == "" ? UIColor.lightGray : .black
        commentTextView.becomeFirstResponder()
        commentTextView.selectedTextRange = commentTextView.textRange(from: commentTextView.beginningOfDocument, to: commentTextView.beginningOfDocument)

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
    }
    @objc func endEditing() {
           view.endEditing(true)
       }

}
extension CommentViewController: UITextViewDelegate {
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        endEditing()
        return true
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)

        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {

            textView.text = "comment_description".localized()
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
