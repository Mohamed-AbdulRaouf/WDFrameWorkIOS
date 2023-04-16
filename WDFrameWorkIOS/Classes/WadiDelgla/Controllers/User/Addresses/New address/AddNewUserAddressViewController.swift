//
//  AddNewUserAddressViewController.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 11/3/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
import RxSwift
 class AddNewUserAddressViewController: STUIViewController ,IBaseController{

    typealias T = IAddNewUserAddressViewModel

    var viewModel: IAddNewUserAddressViewModel?

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var areaButton: UIButton!
    @IBOutlet weak var cityButton: UIButton!
    @IBOutlet weak var floorNoTextField: STErrorTextField!
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var landMartkTextField: UITextField!
    @IBOutlet weak var streetNameTextField: STErrorTextField!
    @IBOutlet weak var buildingNoTextField: STErrorTextField!
    var data = [CityDTODAL]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.bindingData()
        self.viewModel?.viewDidLoad()
    }
   
     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         self.viewModel?.addAddress(completion: {[weak self] value in
             guard let self = self else {return}
             debugPrint(value)
             self.navigationController?.popViewController(animated: true)
         })
     }
    func setupUI(){
        self.addDismissKeyboardTapGesture()
        self.saveButton.setTitle(R.string.localizable.save(), for: .normal)
        self.viewModel?.delegate = self
        [buildingNoTextField,streetNameTextField,landMartkTextField,companyNameTextField,floorNoTextField].forEach {
            $0?.setPlaceHolderTextColor(.lightGray)
            $0?.textColor = COLOR_PRIMARY_TEXT
            $0?.underlineTextField(COLOR_PRIMARY_TEXT)
            $0?.font = APP_FONT_REGULAR16 //UIFont(resource: APP_FONT_REGULAR, size: 16)
            $0?.addPaddingRight(16)
        }
        [floorNoTextField].forEach {
            $0?.keyboardType = .asciiCapableNumberPad
        }
        [cityButton,areaButton].forEach {
            $0?.setTitleColor(COLOR_PRIMARY_TEXT, for: .normal)
            $0?.titleLabel?.font = APP_FONT_REGULAR18 //UIFont(resource: APP_FONT_REGULAR, size: 18)
        }
        [saveButton].forEach { (button) in
            button?.layer.cornerRadius = 18.2
            button?.layer.borderWidth = 1
            button?.layer.borderColor = UIColor.clear.cgColor
            
            button?.layer.shadowColor = UIColor.clear.cgColor
            button?.layer.shadowOffset = CGSize(width: 0, height: 1.0)
            button?.layer.shadowRadius = 2
            button?.layer.masksToBounds = false
            button?.layer.shadowOpacity = 1.0
            // set backgroundColor in order to cover the shadow inside the bounds
            button?.layer.backgroundColor = COLOR_ACCENT.cgColor
 
        }
        //placeholders
        self.floorNoTextField.placeholder = R.string.localizable.floor_no()
        self.companyNameTextField.placeholder = R.string.localizable.company_name()
        self.landMartkTextField.placeholder = R.string.localizable.landmark()
        self.streetNameTextField.placeholder = R.string.localizable.street_name()
        self.buildingNoTextField.placeholder = R.string.localizable.building_no()
        self.cityButton.setTitle(R.string.localizable.select_city(), for: .normal)
        self.areaButton.setTitle(R.string.localizable.select_area(), for: .normal)

       _ =  cityButton.reactive.tap
            .observeNext {
                self.onCityTapped()
        }
       _ =  areaButton.reactive.tap.observeNext {
            self.onAreaTapped()
        }
        buildingNoTextField.maxLength = 5
        floorNoTextField.maxLength = 3
     }
    func bindingData() {
        if let viewModel = viewModel , let address_data = viewModel.address_data{
            address_data.buildingNo.bidirectionalBind(to:  buildingNoTextField.reactive.text)
            address_data.streetName.bidirectionalBind(to:  streetNameTextField.reactive.text)
            address_data.floorNo.bidirectionalBind(to:  floorNoTextField.reactive.text)
            address_data.companyName.bidirectionalBind(to:  companyNameTextField.reactive.text)
            address_data.addressDescription.bidirectionalBind(to:  landMartkTextField.reactive.text)
            
            buildingNoTextField.error = viewModel.errorModel?.msgBuildingNoError
            floorNoTextField.error = viewModel.errorModel?.msgFloorNoError
            streetNameTextField.error = viewModel.errorModel?.msgStreetNameError
            
            self.cityButton.setTitle(viewModel.currentCity == nil ? R.string.localizable.select_city() : viewModel.currentCity?.name.value, for: .normal)
            self.areaButton.setTitle(viewModel.currentArea == nil ? R.string.localizable.select_area() :viewModel.currentArea?.name.value, for: .normal)
            
            [self.cityButton,self.areaButton,self.floorNoTextField,self.buildingNoTextField,self.streetNameTextField,self.landMartkTextField,self.companyNameTextField].forEach {
                $0?.isEnabled = address_data.isAddressValidToUpdate.value ?? true
            }
            self.saveButton.isHidden = !(address_data.isAddressValidToUpdate.value ?? true)
            //From cart
            if let isfromCart = viewModel.isFromCart,isfromCart{
                [self.cityButton,self.areaButton].forEach {
                    $0?.isEnabled = !isfromCart
                }
                [self.floorNoTextField,self.buildingNoTextField,self.streetNameTextField,self.landMartkTextField,self.companyNameTextField].forEach {
                    $0?.isEnabled = isfromCart
                }
            }
         }
    }
    func onCityTapped(){
        let vc = StoryboardScene.Features.searchViewController.instantiate()
        vc.onItemSelect = { [weak self] item in
            self?.viewModel?.currentCity = item
            self?.viewModel?.currentArea = nil
            self?.bindingData()
        }
        vc.data = data
        self.navigationController?.pushViewController(vc)
    }
    func onAreaTapped(){
        if viewModel?.currentCity == nil {
            self.showMessage(andMessage: R.string.localizable.select_city_msg())
            return
        }
        let vc = StoryboardScene.Features.searchViewController.instantiate()
        vc.onItemSelect = { [weak self] item in
            self?.viewModel?.currentArea = item
            self?.bindingData()
        }
        vc.data = self.data.filter({$0.id.value == self.viewModel?.currentCity?.id.value!}).first?.areas.value ?? [SearchItemDTOModelDAL]()
        self.navigationController?.pushViewController(vc)
    }
    @IBAction func onSaveTapped(_ sender: Any) {
        self.viewModel?.onSaveTapped()
    }
    
    
}
extension AddNewUserAddressViewController: IAddNewUserAddressViewController{
    func successUpdateUserAddress() {
        self.bindingData()
        self.showToast(R.string.localizable.success_update_address())
        doOnMain(deadline: 1.0, {
            self.navigationController?.popViewController(animated: true)
        })
    }
    
    func successAddNewAddress() {
//        self.bindingData()
//        self.showToast(R.string.localizable.success_add_address())
//        doOnMain(deadline: 0.2, {
            self.navigationController?.popViewController(animated: true)
//        })
    }
    
    func onError(_ error: String) {
        print(error)
        self.showMessage(andMessage: error)
        self.bindingData()
    }
    func onUpdateLayout() {
        self.bindingData()
    }
    func onSuccessLoadCitiesAndAreas(_ cities: [CityDTODAL]){
        self.data = cities
        self.bindingData()
    }
}

 

