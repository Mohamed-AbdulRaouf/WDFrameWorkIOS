//
//  ProductCommentTableViewCell.swift
//  STDobites
//
//  Created by SimpleTouch on 11/17/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
//import Rswift
class ProductCommentTableViewCell: UITableViewCell,UITextViewDelegate {
    @IBOutlet weak var commentTextView: UITextView!
    var placeholderLabel : UILabel!
    var onChangeComment: ((String) -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        commentTextView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(_ model: String){
        commentTextView.delegate = self
        if model == "" {
            placeholderLabel = UILabel()
            placeholderLabel.text = R.string.localizable.special_instructions_example()
            placeholderLabel.text = ""
            placeholderLabel.font = UIFont(resource: APP_FONT_REGULAR, size: 13)
            placeholderLabel.sizeToFit()
            commentTextView.addSubview(placeholderLabel)
            placeholderLabel.textAlignment = K.shared.APP_LANGUAGE == "ar" ? .right : .left
            if K.shared.APP_LANGUAGE == "ar"{
                placeholderLabel.frame.origin = CGPoint(x: commentTextView.frame.width - 150, y: (commentTextView.font?.pointSize)! / 2)

            }else{
                placeholderLabel.frame.origin = CGPoint(x: 5, y: (commentTextView.font?.pointSize)! / 2)

            }

            placeholderLabel.textColor = UIColor.lightGray
            placeholderLabel.isHidden = !commentTextView.text.isEmpty
            
        }else{
            self.commentTextView.text = model
        }
       
    }
 
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
        self.onChangeComment!(textView.text)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}
