//
//  LoginViewController.swift
//  STDobites
//
//  Created by SimpleTouch on 10/14/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
import SVProgressHUD
import SwinjectStoryboard
import SwifterSwift
//import DAL
class LoginViewController: STUIViewController ,IBaseController{
    
    // MARK: - Properties
    typealias T = ILoginViewModel
    var viewModel: ILoginViewModel?
    weak var delegate : LoginProtocol?
    
    // MARK: - IBOutlets
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var passwordTextField: STErrorTextField!
    @IBOutlet weak var phoneNumberTextField: STErrorTextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var loginButton: STUISecondaryButton!
    @IBOutlet weak var countryCodeButton: UIButton!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //bind UI
        self.addDismissKeyboardTapGesture()
        self.setupUI()
        self.bindingData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.phoneNumberTextField.text = GlobalConstants.shared.mobile.getPhoneNumberOnlyWithCountry
            self.passwordTextField.text = GlobalConstants.shared.password
                    let country = CountryDTODAL(countryId: "12", countryCode: "EG", dialCode: "+20", emoji: "🇪🇬", name: "Egypt", hintNumber: "01001234567")
            UserDefaults.currentAppCountry?.countryCode.value = "EG"
            UserDefaults.currentAppCountry = country
                    self.updateCountryCode(country: country)
                    viewModel?.sendLoginRequest()
    }
    
    // MARK: - IBActions
    @IBAction func onDismissTapped(_ sender: Any) {
        
        self.dismiss(animated: true) {
            self.delegate?.onDismissLogin()
        }
    }
    
    @IBAction func onLoginTapped(_ sender: Any) {
        viewModel?.sendLoginRequest()
    }
    
    @IBAction func onForgotPasswordTapped(_ sender: Any) {
        let vc = StoryboardScene.User.forgotPasswordVerifyCodeViewController.instantiate()
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func onSignupTapped(_ sender: Any) {
        let vc = StoryboardScene.User.registerViewController.instantiate()
        vc.onSuccessRegister = { [weak self] (mobile,countryId,dialCode) in
            self?.showVerificationVC(mobile,countryId,dialCode: dialCode)
        }
        self.present(vc, animated: true, completion: nil)
        
    }
    @IBAction func onCountryCodeTapped(_ sender: Any) {
        
        let vc = StoryboardScene.Features.countryListViewController.instantiate()
        vc.viewModel?.sourceDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    // MARK: - Functions
    func showVerificationVC(_ mobile:String,_ countryId: String,dialCode: String){
        let vc = StoryboardScene.User.verificationCodeViewController.instantiate()
        vc.viewModel?.verificationCodeModel.mobile.value = mobile
        vc.viewModel?.verificationCodeModel.countryId.value = countryId
        vc.viewModel?.verificationCodeModel.dialCode.value = dialCode
        self.present(vc, animated: true, completion: nil)
    }
    
    deinit {
        print("deinit LoginViewController")
    }
}

// MARK: - Internal
extension LoginViewController{
    func setupUI(){
        viewModel?.delegate = self
        [self.phoneNumberTextField,passwordTextField].forEach {
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
        [self.loginButton].forEach {
            $0?.layer.cornerRadius = 10
        }
        self.phoneNumberTextField.keyboardType = .phonePad
        self.passwordTextField.placeholder = "password".localized()
        self.signupButton.setTitle("sign_up".localized(), for: .normal)
        self.loginButton.setTitle("login".localized(), for: .normal)
        
        self.dismissButton.layer.cornerRadius = self.dismissButton.frame.height / 2
        self.dismissButton.setTitle("X", for: .normal)
        self.dismissButton.setTitleColor(.white, for: .normal)
        self.dismissButton.layer.borderWidth = 2
        self.dismissButton.layer.borderColor = COLOR_ACCENT.cgColor
        self.dismissButton.backgroundColor = COLOR_ACCENT
        self.forgotPasswordButton.setTitle("forgot_password".localized(), for: .normal)
        
        if let countrylist = K.shared.ALL_AVAILABLE_COUNTRY_LIST,countrylist.count > 0 {
            self.updateCountryCode(country: countrylist[0])
        }
        
    }
    func bindingData() {
        if let viewModel = viewModel{
            phoneNumberTextField.reactive.text.bind(to: viewModel.user_login_data.mobile)
            passwordTextField.reactive.text.bind(to: viewModel.user_login_data.password)
            
            phoneNumberTextField.error = viewModel.errorModel?.msgPhoneNumberError
            passwordTextField.error = viewModel.errorModel?.msgPasswordError
        }
    }
    func updateCountryCode(country: ICountryDTODAL) {
           self.countryCodeButton.setTitle("\(country.emoji.value ?? "") \(country.dialCode.value ?? "")", for: .normal)
        self.phoneNumberTextField.placeholder = country.hintNumber.value ?? "phone_number".localized()
         self.phoneNumberTextField.maxLength = country.hintNumber.value?.count ?? 0
        self.viewModel?.user_login_data?.countryId = country.countryId
           self.viewModel?.user_login_data?.dialCode = country.dialCode
        self.viewModel?.country_data = country
    }
}

// MARK: - ILoginViewController Protocol
extension LoginViewController: ILoginViewController{
    
    func onSuccessLogin() {
        let vc = StoryboardScene.Location.locationViewController.instantiate()
        self.navigationController?.pushViewController(vc)
    }
    
    func onUpdateLayout() {
        self.bindingData()
    }
    
    func onAcctivateAccount() {
        if let data = self.viewModel?.user_login_data {
            self.showVerificationVC(data.mobile.value ?? "", data.countryId.value ?? "",dialCode: data.dialCode.value ?? "")
        }
    }
    
}

// MARK: - CountrySelectorDelegate Protocol
extension LoginViewController: CountrySelectorDelegate {
    func selectCountry(country: ICountryDTODAL) {
        self.updateCountryCode(country: country)
    }
}
