//
//  RateOrderCommentTableViewCell.swift
//  STDobites
//
//  Created by SimpleTouch on 11/27/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit

// MARK: -
class RateOrderCommentTableViewCell: UITableViewCell {

    // MARK: - Properties
    var onChangeComment: ((String) -> Void)?
    var onSubmitTapped: (() -> Void)?
    
    // MARK: - IBOutlets
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var submitRateBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(_ comment: String,_ isOrderRatedBefore: Bool){
        self.submitRateBtn.titleLabel?.font = FONT_PRIMARY_BUTTON
        self.submitRateBtn.setTitleColor(COLOR_BUTTON_TEXT, for: .normal)
        self.submitRateBtn.layer.cornerRadius = 5
        self.submitRateBtn.setTitle(R.string.localizable.submit(), for: .normal)
        self.commentTextView.layer.cornerRadius = 5
        self.commentTextView.addShadow()
        self.commentTextView.delegate = self
        self.commentTextView.text = comment
        self.commentTextView.isUserInteractionEnabled = !isOrderRatedBefore
        self.submitRateBtn.isHidden = isOrderRatedBefore
        if isOrderRatedBefore {
                   self.commentTextView.isHidden = comment == ""
               }
    }
    
    @IBAction func submitRateTappedBtn(_ sender: Any) {
        self.onSubmitTapped!()
    }
    
}
extension RateOrderCommentTableViewCell : UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        self.onChangeComment!(textView.text)
    }
}
