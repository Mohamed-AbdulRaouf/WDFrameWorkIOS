//
//  RegisterationViewController.swift
//  STDobites
//
//  Created by SimpleTouch on 10/2/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
import ReactiveKit
//import BLL
//import DAL
class RegisterationViewController: STUIViewController,IBaseController,SSRadioButtonControllerDelegate{
    
     // MARK: - Properties
    typealias T = IRegisterViewModel
    var viewModel: IRegisterViewModel?
    var radioButtonController: SSRadioButtonsController?
    var onSuccessRegister: ((String,String,String) -> Void)?

    // MARK: - IBOutlets
    @IBOutlet weak var passwordTextField: STErrorTextField!
    @IBOutlet weak var confirmPasswordTextField: STErrorTextField!
    @IBOutlet weak var emailTextField: STErrorTextField!
    @IBOutlet weak var lastNameTextField: STErrorTextField!
    @IBOutlet weak var firstNameTextField: STErrorTextField!
    @IBOutlet weak var referralCodeTextField: STErrorTextField!
    @IBOutlet weak var phoneNumberTextField: STErrorTextField!
    @IBOutlet weak var notSpecifiyGenderButton: SSRadioButton!
    @IBOutlet weak var femaleButton: SSRadioButton!
    @IBOutlet weak var maleButton: SSRadioButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: STUISecondaryButton!
    @IBOutlet weak var countryCodeButton: UIButton!


    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
         //bind UI
        self.addDismissKeyboardTapGesture()
        self.setupUI()
        self.bindingData()
    }
    
    // MARK: - IBActions
    @IBAction func onRegisterTapped(_ sender: Any) {
        viewModel?.register()
    }
    @IBAction func onLoginTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func onCountryCodeTapped(_ sender: Any) {
          
          let vc = StoryboardScene.Features.countryListViewController.instantiate()
          vc.viewModel?.sourceDelegate = self
          self.present(vc, animated: true, completion: nil)
      }
    // MARK: - Functions
    func didSelectButton(selectedButton: UIButton?) {
        if maleButton.isSelected {
            viewModel?.user_data?.gender.value = Gender.male.rawValue
        }
        else if femaleButton.isSelected {
            viewModel?.user_data?.gender.value = Gender.female.rawValue
        }
        else if notSpecifiyGenderButton.isSelected {
            viewModel?.user_data?.gender.value = Gender.none.rawValue
        }
        else if !maleButton.isSelected && !femaleButton.isSelected && !notSpecifiyGenderButton.isSelected {
            self.notSpecifiyGenderButton.isSelected = true
        }
    }
    
    deinit {
        print("deinit Registeration")
    }
}

// MARK: - Internal
extension RegisterationViewController{
    func setupUI(){
        self.viewModel?.delegate = self
        viewModel?.user_data?.gender.value = Gender.male.rawValue
        [self.phoneNumberTextField,referralCodeTextField,firstNameTextField,lastNameTextField,emailTextField,passwordTextField,confirmPasswordTextField].forEach {
            $0?.font = APP_FONT_REGULAR16 //UIFont(resource: APP_FONT_REGULAR, size: 17)
            $0?.textColor = .black
            $0?.setPlaceHolderTextColor(.black)
            
            $0?.backgroundColor = .white
            $0?.layer.cornerRadius = 20
            $0?.addPaddingLeft(16)
            $0?.addPaddingRight(16)
        }
        [self.countryCodeButton].forEach {
                  $0?.titleLabel?.font = APP_FONT_REGULAR16 //UIFont(resource: APP_FONT_REGULAR, size: 17)
            $0?.setTitleColor(.black, for: .normal)
                  $0?.backgroundColor = .white
                  $0?.layer.cornerRadius = 20
                  $0?.setTitle("", for: .normal)
              }
        self.phoneNumberTextField.keyboardType = .phonePad
        self.passwordTextField.isSecureTextEntry = true
        self.confirmPasswordTextField.isSecureTextEntry = true
        
        self.notSpecifiyGenderButton.titleLabel?.adjustsFontSizeToFitWidth = true
        self.notSpecifiyGenderButton.titleLabel?.minimumScaleFactor = 0.5;

        radioButtonController = SSRadioButtonsController(buttons: maleButton, femaleButton, notSpecifiyGenderButton)
        radioButtonController!.delegate = self
        radioButtonController!.shouldLetDeSelect = true
        
        [maleButton,femaleButton,notSpecifiyGenderButton].forEach {
            $0?.circleColor = COLOR_ACCENT
            $0?.strokeColor = COLOR_PRIMARY_TEXT
            $0?.circleRadius = 10.0
        }
        
        maleButton.isSelected = true
        
        // Localizable
        
//        self.phoneNumberTextField.placeholder = R.string.localizable.phone_number()
        self.referralCodeTextField.placeholder = R.string.localizable.referral_code()
        self.firstNameTextField.placeholder = R.string.localizable.first_name()
        self.lastNameTextField.placeholder = R.string.localizable.last_name()
        self.emailTextField.placeholder = R.string.localizable.email_address()
        self.passwordTextField.placeholder = R.string.localizable.password()
        self.confirmPasswordTextField.placeholder = R.string.localizable.confirm_password()
        self.notSpecifiyGenderButton.setTitle(R.string.localizable.specify_later(), for: .normal)
        self.maleButton.setTitle(R.string.localizable.male(), for: .normal)
        self.femaleButton.setTitle(R.string.localizable.female(), for: .normal)
        self.signupButton.setTitle(R.string.localizable.sign_up(), for: .normal)
        self.loginButton.setTitle(R.string.localizable.have_an_account_login_in(), for: .normal)
        
        if let countrylist = K.shared.ALL_AVAILABLE_COUNTRY_LIST,countrylist.count > 0 {
            self.updateCountryCode(country: countrylist[0])
        }
              
    }
    func bindingData() {
        if let viewModel = viewModel , let user_data = viewModel.user_data{
            phoneNumberTextField.reactive.text.bind(to: user_data.mobile)
            referralCodeTextField.reactive.text.bind(to:user_data.shareCode)
            firstNameTextField.reactive.text.bind(to:user_data.firstName)
            lastNameTextField.reactive.text.bind(to: user_data.lastName)
            emailTextField.reactive.text.bind(to: user_data.email)
            passwordTextField.reactive.text.bind(to: user_data.password)
            confirmPasswordTextField.reactive.text.bind(to: user_data.confirmPassword)
            phoneNumberTextField.error = viewModel.errorModel?.msgPhoneNumberError
            firstNameTextField.error = viewModel.errorModel?.msgFirstNAmeError
            lastNameTextField.error = viewModel.errorModel?.msgLastNameError
            emailTextField.error = viewModel.errorModel?.msgEmailError
            passwordTextField.error = viewModel.errorModel?.msgPasswordError
            confirmPasswordTextField.error = viewModel.errorModel?.msgConfirmPasswordError
        }
    }
    func updateCountryCode(country: ICountryDTODAL) {
        self.countryCodeButton.setTitle("\(country.emoji.value ?? "") \(country.dialCode.value ?? "")", for: .normal)
        self.phoneNumberTextField.placeholder = country.hintNumber.value ?? R.string.localizable.phone_number()
         self.phoneNumberTextField.maxLength = country.hintNumber.value?.count ?? 0
        self.viewModel?.user_data?.countryId = country.countryId
        self.viewModel?.user_data?.dialCode = country.dialCode
        self.viewModel?.country_data = country
    }
}

// MARK: - IRegisterViewController Protocol
extension RegisterationViewController: IRegisterViewController{
    func onError(_ error: String) {
        print(error)
        self.showMessage(andMessage: error)
        self.bindingData()
    }
    func onUpdateLayout() {
        self.bindingData()
    }
    func successfullyRegister(){
        self.bindingData()
        self.dismiss(animated: true, completion: {
            self.onSuccessRegister!(self.viewModel?.user_data?.mobile.value ?? "",self.viewModel?.user_data?.countryId.value ?? "",self.viewModel?.user_data?.dialCode.value ?? "")
        })
    }
}
//MARK: - CountrySelectorDelegate
extension RegisterationViewController : CountrySelectorDelegate {
    func selectCountry(country: ICountryDTODAL) {
        self.updateCountryCode(country: country)
    }
}
