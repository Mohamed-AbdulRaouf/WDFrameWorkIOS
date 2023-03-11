//
//  ImageZoomingViewController.swift
//  HamamAbdo
//
//  Created by SimpleTouch on 7/19/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import UIKit

class ImageZoomingViewController: STUIViewController,UIScrollViewDelegate {
     @IBOutlet weak var scrollView : UIScrollView?
  @IBOutlet weak var itemImageView : UIImageView?
    var image : UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        commonInit()
        
    }

    func commonInit(){
        itemImageView?.image = image
        itemImageView?.backgroundColor = .white
        itemImageView?.contentMode = .scaleAspectFit
        itemImageView?.clipsToBounds = true
        itemImageView?.isUserInteractionEnabled = true
        scrollView?.delegate = self

        scrollView?.backgroundColor = .clear
        scrollView?.alwaysBounceVertical = false
        scrollView?.alwaysBounceHorizontal = false
        scrollView?.showsVerticalScrollIndicator = true
        scrollView?.flashScrollIndicators()

        scrollView?.minimumZoomScale = 1.0
        scrollView?.maximumZoomScale = 8.0

        
    }
    @IBAction func onDismissButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return itemImageView
    }
    
}
