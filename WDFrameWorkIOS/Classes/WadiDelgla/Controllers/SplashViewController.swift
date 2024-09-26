//
//  SplashViewController.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 10/27/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
//import BLL
//import DAL
//MARK: - IBOutlets & Variables
class SplashViewController: STUIViewController,IBaseController {
    var viewModel: ISplashViewModel?
    typealias T = ISplashViewModel
    @IBOutlet weak var title1Label: UILabel!
    @IBOutlet weak var title2Label: UILabel!
    
}
//MARK: - View Life Cycle
extension SplashViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.bindingData()
        self.viewModel?.delegate = self
      DispatchQueue.main.async(execute: {
                  setup(with: Config.self, completion: {
                      DispatchQueue.global(qos: .background).async {
                                         getErrorMessages(completion: {
                                             
                                         })
                                     }
                      doOnMain(deadline: 0.0) {
                        UserDefaults.enableShowQRCodeVC = true
                          self.viewModel?.viewDidLoad()
                      }
                     
                  })
              })
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setStatusBarStyle(.lightContent)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setStatusBarStyle(.darkContent)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
  
}
//MARK: - Internal
extension SplashViewController {
    func bindingData() {
        self.title1Label.text = R.string.localizable.logo_title1()
        self.title2Label.text = R.string.localizable.logo_title2()
    }
}
//MARK: - ISplashViewController Protocol
extension SplashViewController: ISplashViewController {
    func onPresentLocation() {
        let vc = StoryboardScene.Location.locationViewController.instantiate()
        self.navigationController?.pushViewController(vc)
    }
    
    func onPresentCountryList() {
        let vc = StoryboardScene.Features.countryListViewController.instantiate()
        vc.viewModel?.sourceDelegate = self
        vc.viewModel?.brandId = Config.BRAND_ID
        self.navigationController?.pushViewController(vc)
    }
    func onPresentQRCodeVC(){
        UserDefaults.enableShowQRCodeVC = false
        let vc = StoryboardScene.Features.qRcodeViewController.instantiate()
        vc.sourceDelegate = self
        vc.onDismissQRVC = { isScaned in
            self.viewModel?.viewDidLoad()
        }
        self.navigationController?.pushViewController(vc)
    }
    
}
//MARK: - CountrySelectorDelegate Protocol
extension SplashViewController : CountrySelectorDelegate {
    func selectCountry(country: ICountryDTODAL) {
        UserDefaults.currentAppCountry = country as? CountryDTODAL
        self.onPresentLocation()
    }
}
