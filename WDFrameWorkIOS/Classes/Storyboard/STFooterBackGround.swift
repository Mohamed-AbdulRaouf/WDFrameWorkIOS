//
//  STFooterBackGround.swift
//  DoBites
//
//  Created by SimpleTouch on 8/21/19.
//  Copyright © 2019 Nermeen Mohdamed. All rights reserved.
//

import UIKit
@IBDesignable
public class STFooterBackGround: UIView {


    var contentView:UIView?
    @IBInspectable var nibName:String?
 
    public override func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
    }
    
    func xibSetup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        guard let nibName = nibName else { return nil }
//        let bundle = Bundle(for: type(of: self))
        let bundlePath = Bundle(for: UserTestPath.self).path(forResource: "resources", ofType: "bundle")
        let bundle = Bundle(path: bundlePath!)
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
        contentView?.prepareForInterfaceBuilder()
    }
}
