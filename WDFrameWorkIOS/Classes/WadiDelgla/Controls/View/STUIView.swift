//
//  STUIView.swift
//  Auntie Annes
//
//  Created by Mohammed Habib on 1/8/19.
//  Copyright © 2019 Mohammed Habib. All rights reserved.
//

import UIKit

class STUIView: UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [COLOR_PRIMARY
            .cgColor, COLOR_ACCENT.cgColor]
        self.layer.insertSublayer(gradient, at: 0)
    }
}
