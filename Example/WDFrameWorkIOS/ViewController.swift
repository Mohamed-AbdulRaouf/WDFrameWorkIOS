//
//  ViewController.swift
//  WDFrameWorkIOS
//
//  Created by mohamed.a.raouf@icloud.com on 03/09/2023.
//  Copyright (c) 2023 mohamed.a.raouf@icloud.com. All rights reserved.
//

import UIKit
import WDFrameWorkIOS

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let log = LoggerPrint()
        log.printText(text: "Hello")
        
        //        let dd = MainStoryboardScene.shared.splashViewControllerVC()
        //        self.present(dd, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnTapped(_ sender: Any) {
        
        let bundlePath = Bundle(for: TestViewController.self).path(forResource: "resources", ofType: "bundle")
        let bundle = Bundle(path: bundlePath!)
        let storyboard: UIStoryboard = UIStoryboard(name: "LaunchScreen", bundle: bundle)
        let vc = storyboard.instantiateInitialViewController()! //instantiateViewController(withIdentifier: "QRcodeViewController")
        self.present(vc, animated: false, completion: nil)
    }
    
}
