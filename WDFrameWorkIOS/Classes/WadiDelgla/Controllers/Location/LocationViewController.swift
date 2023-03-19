//
//  LocationViewController.swift
//  TestSearchBar
//
//  Created by Nermeen Mohamed on 10/23/19.
//  Copyright © 2019 Nermeen Mohamed. All rights reserved.
//

import UIKit
import FirebaseCore

// MARK: - IBOutlets & Variables
class LocationViewController :STUIViewController ,IBaseController{
    
    typealias T = ILocationViewModel
    var viewModel: ILocationViewModel?
    
    @IBOutlet weak var languageButton: UIButton!
    @IBOutlet weak var startButton: STUISecondaryButton!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var areaButton: UIButton!
    @IBOutlet weak var cityButton: UIButton!
    @IBOutlet weak var countryButton: UIButton!
    @IBOutlet weak var title1Label: UILabel!
    @IBOutlet weak var title2Label: UILabel!
    
    
    var selectedCity: SearchItemDTODAL?
    var selectedArea: SearchItemDTODAL?
    var data = [CityDTODAL]()
}

// MARK: - ViewLifeCycle
extension LocationViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //initialize data
        viewModel?.getCitiesAndAreas()
        //bind UI
        self.addDismissKeyboardTapGesture()
        self.setupUI()
        self.bindingData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarHidden(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItem.title = ""
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setNavigationBarHidden(false)
    }
}
//MARK: - IBActions
extension LocationViewController {
    @IBAction func onCityTapped(_ sender: Any) {
        let vc = StoryboardScene.Features.searchViewController.instantiate()
        vc.onItemSelect = { [weak self] item in
            self?.viewModel?.currentCity = item
            self?.viewModel?.currentArea = nil
            self?.bindingData()
        }
        vc.data = data
        vc.title = R.string.localizable.club()
        self.navigationController?.pushViewController(vc)
        
    }
    
    @IBAction func onAreaTapped(_ sender: Any) {
        if viewModel?.currentCity == nil {
            self.showMessage(andMessage: R.string.localizable.select_government_msg())
            return
        }
        let vc = StoryboardScene.Features.searchViewController.instantiate()
        vc.onItemSelect = { [weak self] item in
            self?.viewModel?.currentArea = item
            self?.bindingData()
        }
        vc.data = self.data.filter({$0.id.value == self.viewModel?.currentCity?.id.value!}).first?.areas.value ?? [SearchItemDTOModelDAL]()
        vc.title = R.string.localizable.area()
        self.navigationController?.pushViewController(vc)
        
    }
    @IBAction func onStartTapped(_ sender: Any) {
        viewModel?.validateOnChangeLocation()
    }
    @IBAction func onChangeLanguageTapped(_ sender: Any) {
        viewModel?.validateOnCartHasItems()
    }
    @IBAction func onCountryTapped(_ sender: Any) {
        let vc = StoryboardScene.Features.countryListViewController.instantiate()
        vc.viewModel?.sourceDelegate = self
        vc.viewModel?.brandId = Config.BRAND_ID
        present(vc, animated: true, completion: nil)
    }
    func reloadData() {
        self.bindingData()
    }
}

// MARK: - Internal
extension LocationViewController{
    func setupUI(){
        self.viewModel?.delegate = self
//        self.startButton.backgroundColor = COLOR_ACCENT
        self.title1Label.text = R.string.localizable.logo_title1()
        self.title2Label.text = "Order the Food You Love".localized()
        self.title1Label.font = APP_FONT_BOLD18 //UIFont.init(resource: APP_FONT_BOLD, size: 18)
        self.title2Label.font = APP_FONT_BOLD18 //UIFont.init(resource: APP_FONT_BOLD, size: 18)

        self.startButton.layer.cornerRadius = 30
        self.startButton.layer.borderColor = UIColor.clear.cgColor
        self.startButton.titleLabel?.font = FONT_PRIMARY_BUTTON
        self.startButton.setTitle(R.string.localizable.order(), for: .normal)
        
        self.cityLabel.text = R.string.localizable.club()
        self.areaLabel.text = R.string.localizable.area()
        self.cityButton.setTitle(R.string.localizable.select_government(), for: .normal)
        self.areaButton.setTitle(R.string.localizable.select_club(), for: .normal)
        let lang = K.shared.APP_LANGUAGE == "ar"  ? "English" : "العربية"
        self.languageButton.setTitle(lang, for: .normal)
        
        /*
        if let country = UserDefaults.currentAppCountry ,let countries = K.shared.BRAND_COUNTRY_LIST,countries.count > 1{
            self.updateCountryCode(country: country)
        }else{
            self.countryButton.isHidden = true
        }
        */
        self.countryButton.isHidden = true
    }
    func bindingData() {
        
        if let viewModel = viewModel{
            
            self.cityButton.setTitle(viewModel.currentCity == nil ? R.string.localizable.select_government() : viewModel.currentCity?.name.value, for: .normal)
            self.areaButton.setTitle(viewModel.currentArea == nil ? R.string.localizable.select_club() :viewModel.currentArea?.name.value, for: .normal)
        }
    }
    
}
// MARK:- Configuration Functions
extension LocationViewController {
    func updateCountryCode(country: ICountryDTODAL) {
        self.countryButton.setTitle("\(country.name.value ?? "") \(country.emoji.value ?? "")", for: .normal)
        self.countryButton.setTitleColor(.white, for: .normal)
        self.countryButton.titleLabel?.font = APP_FONT_BOLD //UIFont(resource: APP_FONT_BOLD, size: 20)
    }
    
    
    func onShowClearCartAlert(messageText: String, actionButtonText : String, actionButtonClosure: @escaping () -> Void) {
        let alertVC = UIAlertController(title: "", message: messageText, preferredStyle: .actionSheet)
        let clearAction = UIAlertAction(title: actionButtonText, style: .destructive) { (pressed) in
            actionButtonClosure()
        }
        let cancelAction = UIAlertAction(title: R.string.localizable.cancel(), style: .cancel, handler: nil)
        alertVC.addAction(clearAction)
        alertVC.addAction(cancelAction)
        present(alertVC, animated: true, completion: nil)
    }
}

// MARK: - ILocationViewController Protocol
extension LocationViewController: ILocationViewController{
    
    func openHome(){
//        let vc = StoryboardScene.Main.tabBarViewController.instantiate()
//        UIApplication.shared.keyWindow?.rootViewController = vc
        let vc = StoryboardScene.Main.exploreViewController.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func onSuccessLoadCitiesAndAreas(_ cities: [CityDTODAL]) {
        self.data = cities
        let city =  cities.filter({$0.id.value ?? "" == self.viewModel?.currentCity?.id.value ?? ""}).first

        let areas = cities.filter({$0.id.value ?? "" == self.viewModel?.currentCity?.id.value ?? ""}).first?.areas.value ?? [SearchItemDTOModelDAL]()
//        for area in areas {
//            showAlert(title: area.name.value ?? "nnn", message: area.id.value ?? "id")
//        }
        let area = areas.filter({$0.id.value ?? "" == self.viewModel?.currentArea?.id.value ?? ""}).first ?? SearchItemDTOModelDAL()
//        showAlert(title: area.name.value ?? "nnn", message: self.viewModel?.currentArea?.id.value ?? "id")
        
//        showAlert(title:city?.name.value, message: "\(cities[0].id.value ?? "") - \(self.viewModel?.currentCity?.id.value ?? "") - \(cities[0].name.value ?? "")  - \(area.name.value ?? "") - \(area.id.value ?? "")")
//        self.viewModel?.checkCityName(cities)
//        self.viewModel?.checkAreaName(cities)
        
    }
    func onShowClearCartAlert() {
        let alertVC = UIAlertController(title: "", message: R.string.localizable.clear_cart_due_to_change_location(), preferredStyle: .actionSheet)
        let clearAction = UIAlertAction(title: R.string.localizable.clear_cart(), style: .destructive) { (pressed) in
            self.viewModel?.cartService?.deleteCart(completion: { (success) in
                if success{
                    UserDefaults.brandPaymentData = nil
                    self.openHome()
                }
            })
        }
        let cancelAction = UIAlertAction(title: R.string.localizable.cancel(), style: .cancel, handler: nil)
        
        alertVC.addAction(clearAction)
        alertVC.addAction(cancelAction)
        present(alertVC, animated: true, completion: nil)
    }
    func onShowClearCartByChangingLanguage(){
        let alertVC = UIAlertController(title: "", message: R.string.localizable.clear_cart_due_to_change_language(), preferredStyle: .actionSheet)
        let clearAction = UIAlertAction(title: R.string.localizable.clear_cart(), style: .destructive) { (pressed) in
            self.viewModel?.cartService?.deleteCart(completion: { (success) in
                if success{
                    changeLanguage()
                }
            })
        }
        let cancelAction = UIAlertAction(title: R.string.localizable.cancel(), style: .cancel, handler: nil)
        alertVC.addAction(clearAction)
        alertVC.addAction(cancelAction)
        present(alertVC, animated: true, completion: nil)
    }
    
}
//MARK: - CountrySelectorDelegate Protocol
extension LocationViewController : CountrySelectorDelegate {
    func selectCountry(country: ICountryDTODAL) {
        print("OLd Country = \(String(describing: UserDefaults.currentAppCountry?.countryCode.value ?? ""))")
        self.viewModel?.validateOnCartHasItemsForCountry(country: country)
    }
}
