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
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var languageButton: UIButton!
    @IBOutlet weak var startButton: STUISecondaryButton!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var areaButton: UIButton!
    @IBOutlet weak var cityButton: UIButton!
    @IBOutlet weak var countryButton: UIButton!
    @IBOutlet weak var title1Label: UILabel!
    @IBOutlet weak var title2Label: UILabel!
    @IBOutlet weak var myOrdersBtn: UIButton!
    
    var selectedCity: SearchItemDTODAL?
    var selectedArea: SearchItemDTODAL?
    var data = [CityDTODAL]()
}

// MARK: - ViewLifeCycle
extension LocationViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
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
        self.myOrdersBtn.setTitle("my_orders".localized(), for: .normal)
        if L102Language.isCurrentLanguageArabic() {
            backBtn.setImage(UIImage(named: "ic_back_ar"), for: .normal)
        } else {
            backBtn.setImage(UIImage(named: "ic_back"), for: .normal)
        }
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
    @IBAction func onCityTapped(_ sender: UIButton) {
        let vc = StoryboardScene.Features.searchViewController.instantiate()
        vc.onItemSelect = { [weak self] item in
            self?.viewModel?.currentCity = item
            self?.viewModel?.currentArea = nil
            self?.bindingData()
        }
        vc.data = data
        vc.title = "club".localized()
        self.navigationController?.pushViewController(vc)
        
    }
    
    @IBAction func onAreaTapped(_ sender: Any) {
        if viewModel?.currentCity == nil {
            self.showMessage(andMessage: "select_government_msg".localized())
            return
        }
        let vc = StoryboardScene.Features.searchViewController.instantiate()
        vc.onItemSelect = { [weak self] item in
            self?.viewModel?.currentArea = item
            self?.bindingData()
        }
        vc.data = self.data.filter({$0.id.value == self.viewModel?.currentCity?.id.value!}).first?.areas.value ?? [SearchItemDTOModelDAL]()
        vc.title = "area".localized()
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
    
    @IBAction func onMyOrdersBtnTapped(_ sender: Any) {
        let vc = StoryboardScene.User.orderListViewController.instantiate()
        self.navigationController?.pushViewController(vc)
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        // back to main app
        doPostNotification("exit_wdframework")
    }
    
}

// MARK: - Internal
extension LocationViewController{
    func setupUI(){
        self.viewModel?.delegate = self
//        self.startButton.backgroundColor = COLOR_ACCENT
        self.title1Label.text = "logo_title1".localized()
        self.title2Label.text = "Order the Food You Love".localized()
        self.title1Label.font = APP_FONT_BOLD18 //UIFont.init(resource: APP_FONT_BOLD, size: 18)
        self.title2Label.font = APP_FONT_BOLD18 //UIFont.init(resource: APP_FONT_BOLD, size: 18)

        self.startButton.layer.cornerRadius = 30
        self.startButton.layer.borderColor = UIColor.clear.cgColor
        self.startButton.titleLabel?.font = FONT_PRIMARY_BUTTON
        self.startButton.setTitle("order".localized(), for: .normal)
        
        self.cityLabel.text = "select_club".localized()
        self.areaLabel.text = "select_area".localized()
        self.cityButton.setTitle("select_club".localized(), for: .normal)
        self.areaButton.setTitle("select_area".localized(), for: .normal)
        let lang = LocalizationSystem.sharedInstance.isCurrentLanguageArabic()  ? "English" : "العربية"
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
            
            self.cityButton.setTitle(viewModel.currentCity == nil ? "select_club".localized() : viewModel.currentCity?.name.value, for: .normal)
            self.areaButton.setTitle(viewModel.currentArea == nil ? "select_area".localized() :viewModel.currentArea?.name.value, for: .normal)
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
        let cancelAction = UIAlertAction(title: "cancel".localized(), style: .cancel, handler: nil)
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
        self.navigationController?.pushViewController(vc)
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
        let alertVC = UIAlertController(title: "", message: "clear_cart_due_to_change_location".localized(), preferredStyle: .actionSheet)
        let clearAction = UIAlertAction(title: "clear_cart".localized(), style: .destructive) { (pressed) in
            self.viewModel?.cartService?.deleteCart(completion: { (success) in
                if success{
                    UserDefaults.brandPaymentData = nil
                    self.openHome()
                }
            })
        }
        let cancelAction = UIAlertAction(title: "cancel".localized(), style: .cancel, handler: nil)
        
        alertVC.addAction(clearAction)
        alertVC.addAction(cancelAction)
        present(alertVC, animated: true, completion: nil)
    }
    func onShowClearCartByChangingLanguage(){
        let alertVC = UIAlertController(title: "", message: "clear_cart_due_to_change_language".localized(), preferredStyle: .actionSheet)
        let clearAction = UIAlertAction(title: "clear_cart".localized(), style: .destructive) { (pressed) in
            self.viewModel?.cartService?.deleteCart(completion: { (success) in
                if success{
                    changeLanguage()
                }
            })
        }
        let cancelAction = UIAlertAction(title: "cancel".localized(), style: .cancel, handler: nil)
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
extension URL {
    static var documentsDirectory: URL {
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return try! documentsDirectory.asURL()
    }

    static func urlInDocumentsDirectory(with filename: String) -> URL {
        return documentsDirectory.appendingPathComponent(filename)
    }
}
