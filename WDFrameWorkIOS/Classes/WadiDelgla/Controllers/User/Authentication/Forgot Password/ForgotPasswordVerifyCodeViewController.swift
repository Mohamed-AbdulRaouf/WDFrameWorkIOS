//
//  ForgotPasswordVerifyCodeViewController.swift
//  STDobites
//
//  Created by SimpleTouch on 10/16/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
//import DAL
class ForgotPasswordVerifyCodeViewController: STUIViewController, IBaseController {
    
    // MARK: - Properties
    typealias T = IForgotPasswordVerifyCodeViewModel
    var viewModel: IForgotPasswordVerifyCodeViewModel?

    // MARK: - IBOutlets
    @IBOutlet weak var phoneNumberTextField: STErrorTextField!
    @IBOutlet weak var dismissButton: STSkipButton!
    @IBOutlet weak var sendVerifyCodeButton: UIButton!
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
    @IBAction func onSendVerifyCodeTapped(_ sender: Any) {
        viewModel?.getUser()
    }
    
    @IBAction func onDismissTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func onCountryCodeTapped(_ sender: Any) {
           
           let vc = StoryboardScene.Features.countryListViewController.instantiate()
           vc.viewModel?.sourceDelegate = self
           self.present(vc, animated: true, completion: nil)
       }
    // MARK: - Functions
    @objc func updateView(_ notification: Notification){
        self.bindingData()
    }
    
    deinit {
        print("deinit Forgot Password send verify code")
    }
}

// MARK: - Internal
extension ForgotPasswordVerifyCodeViewController{
    func setupUI(){
        self.viewModel?.delegate = self
        [self.phoneNumberTextField].forEach {
            $0?.font = UIFont(resource: APP_FONT_REGULAR, size: 17)
            $0?.textColor = .black
            $0?.setPlaceHolderTextColor(.black)
            
            $0?.backgroundColor = .white
            $0?.layer.cornerRadius = 25
            $0?.addPaddingLeft(16)
            $0?.addPaddingRight(16)
        }
        [self.sendVerifyCodeButton].forEach {
            $0?.layer.cornerRadius = 25
            $0?.backgroundColor = COLOR_ACCENT
            
        }
        [self.countryCodeButton].forEach {
                  $0?.titleLabel?.font = UIFont(resource: APP_FONT_REGULAR, size: 17)
            $0?.setTitleColor(.black, for: .normal)
                  $0?.backgroundColor = .white
                  $0?.layer.cornerRadius = 20
                  $0?.setTitle("", for: .normal)
                 
              }
        self.phoneNumberTextField.keyboardType = .phonePad
        
        self.phoneNumberTextField.placeholder = R.string.localizable.phone_number()
        self.sendVerifyCodeButton.setTitle(R.string.localizable.send_code(), for: .normal)
        self.sendVerifyCodeButton.titleLabel?.font = FONT_PRIMARY_BUTTON
        
        if let countrylist = K.shared.ALL_AVAILABLE_COUNTRY_LIST,countrylist.count > 0 {
            self.updateCountryCode(country: countrylist[0])
        }
                
        
    }
    func bindingData(){
        if let viewModel = viewModel {
            phoneNumberTextField.reactive.text.bind(to: viewModel.verificationCodeModel.mobile)
            phoneNumberTextField.error = viewModel.errorModel?.msgPhoneNumberError
        }
        
    }
   
    func updateCountryCode(country: ICountryDTODAL) {
          self.countryCodeButton.setTitle("\(country.emoji.value ?? "") \(country.dialCode.value ?? "")", for: .normal)
        self.phoneNumberTextField.placeholder = country.hintNumber.value ?? R.string.localizable.phone_number()
         self.phoneNumberTextField.maxLength = country.hintNumber.value?.count ?? 0
        self.viewModel?.verificationCodeModel?.countryId = country.countryId
          self.viewModel?.verificationCodeModel?.dialCode = country.dialCode
      }
}

// MARK: - IForgetPasswordViewController Protocol
extension ForgotPasswordVerifyCodeViewController: IForgetPasswordViewController{
    func onError(_ error: String) {
            self.bindingData()
            self.showMessage(andMessage: error)
    }
    
    func onUpdateLayout() {
        self.bindingData()
    }
    
   func onSuccess(_ model :IAuthPhoneNumberDTODAL) {
        self.bindingData()
        self.dismiss(animated: true, completion: {
            showResetPasswordVC(model)
        })
    }
  
}

// MARK: - CountrySelectorDelegate Protocol
extension ForgotPasswordVerifyCodeViewController: CountrySelectorDelegate {
    func selectCountry(country: ICountryDTODAL) {
        self.updateCountryCode(country: country)

    }
}
