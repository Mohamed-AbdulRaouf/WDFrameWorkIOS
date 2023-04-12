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
    
    @IBOutlet weak var homeStartBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.homeStartBtn.setTitle("Wadi Degla Framework".localized(), for: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnTapped(_ sender: Any) {
        
        let bundlePath = Bundle(for: TestViewController.self).path(forResource: "resources", ofType: "bundle")
        let bundle = Bundle(path: bundlePath!)
        let WDStoryboard: UIStoryboard = UIStoryboard(name: "TestStoryboard", bundle: bundle)
        let vc = WDStoryboard.instantiateViewController(withIdentifier: "TestViewController") as! TestViewController
        let firstScreenWDframework = vc.create(name: "raouf", mobile: "+201226372125", email: "mohamed.a.raouf@icloud.com", membershipNumber: "0040071777", mainStoryboard: UIStoryboard(name: "Main", bundle: Bundle.main), viewController: UIApplication.topViewController() ?? UIViewController(), language: LocalizationSystem.sharedInstance.getLanguage())
        // set app delegate to push view controller
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let rootViewController = appDelegate?.window?.rootViewController as? UINavigationController
        rootViewController?.pushViewController(firstScreenWDframework, animated: true)
    }
    
}
