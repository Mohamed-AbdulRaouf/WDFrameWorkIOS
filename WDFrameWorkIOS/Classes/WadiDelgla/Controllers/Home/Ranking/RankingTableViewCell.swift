//
//  RankingTableViewCell.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 10/29/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
//import DAL
class RankingTableViewCell: UITableViewCell,IBaseTableViewCell {
    
    
    typealias T = ITopRatedReferralsDTODAL
    

    @IBOutlet weak var referralsCountLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var indexButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(_ model: ITopRatedReferralsDTODAL){}
    func configureCell(_ model: ITopRatedReferralsDTODAL,totalReferral:Int) {
        self.referralsCountLabel.text = "\(model.referralsCount.value!)"
        self.indexButton.setTitle("\(model.index.value!)", for: .normal)
        progressView.progress = 0.0
        progressView.progressTintColor = .orange
        progressView.trackTintColor = .clear
        progressView.layer.cornerRadius = 12.5
        progressView.clipsToBounds = true
        progressView.layer.sublayers![1].cornerRadius = 10
        progressView.subviews[1].clipsToBounds = true
        
        let count = CGFloat(CGFloat(CGFloat(model.referralsCount.value ?? 0 ) + 5) / CGFloat(totalReferral))
        UIView.animate(withDuration: 3, animations: { () -> Void in
            self.progressView.setProgress(Float(count), animated: true)
        })
    }
}
