//
//  VerificationCodeViewController.swift
//  STDobites
//
//  Created by SimpleTouch on 10/22/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit

class VerificationCodeViewController: STUIViewController ,IBaseController{
    
    // MARK: - Properties
    typealias T = IVerificationCodeViewModel
    var viewModel: IVerificationCodeViewModel?
    var countDown = 60

    // MARK: - IBOutlets
    @IBOutlet weak var counterDownLabel: UILabel!
    @IBOutlet weak var resendCodeButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var verifyCodeButton: UIButton!
    @IBOutlet weak var verifyCodeTextField: STErrorTextField!
    @IBOutlet weak var phoneNumberTextField: STErrorTextField!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //bind UI
        self.addDismissKeyboardTapGesture()
        self.setupUI()
        self.bindingData()
         self.viewModel?.sendVerifyCode()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    // MARK: - IBActions
    @IBAction func onDismissTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func onVerifyCodeTapped(_ sender: Any) {
        self.viewModel?.validateVerificationCode()
    }
    @IBAction func onTappedResendVerifyCode(_ sender: Any) {
        self.viewModel?.sendVerifyCode()
    }
    
    // MARK: - Functions
    @objc func updateCounter() {
        if(countDown > 0) {
            self.resendCodeButton.isEnabled = false
            countDown -= 1
            counterDownLabel.text = String(countDown) + " " + R.string.localizable.seconds()
        }else{
            self.resendCodeButton.isEnabled = true
        }
    }
    func resetCount(){
        self.resendCodeButton.isEnabled = false
        self.countDown = 60
    }
}

// MARK: - Internal
extension VerificationCodeViewController{
    func setupUI(){
        self.viewModel?.delegate = self
        
        [self.verifyCodeTextField,self.phoneNumberTextField].forEach {
            $0.font = APP_FONT_REGULAR16 //UIFont(resource: APP_FONT_REGULAR, size: 17)
            $0.textColor = .black
            $0.setPlaceHolderTextColor(.black)

            $0.backgroundColor = .white
            $0.layer.cornerRadius = 25
            $0.addPaddingLeft(16)
        }
        [self.verifyCodeButton].forEach {
            $0?.layer.cornerRadius = 25
            $0?.backgroundColor = COLOR_ACCENT
            $0?.titleLabel?.font = FONT_PRIMARY_BUTTON
            $0?.setTitle(R.string.localizable.verify(), for: .normal)
        }
        skipButton.setTitle(R.string.localizable.skip(), for: .normal)
        
        self.verifyCodeTextField.keyboardType = .numberPad
        self.verifyCodeTextField.placeholder = R.string.localizable.verify_code()
        self.phoneNumberTextField.placeholder = R.string.localizable.phone_number()
        
        self.resendCodeButton.setTitle(R.string.localizable.resend_code(), for: .normal)
        
        
        let attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(string: R.string.localizable.havenT_received_Code(),
                                                   attributes: [.underlineStyle: 0]))

#if swift(>=5.0)
print("Running Swift 5.0 or later")
        attributedString.append(NSAttributedString(string: R.string.localizable.resend_code(),
                                                   attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue]))
#else
print("Running old Swift")
        attributedString.append(NSAttributedString(string: R.string.localizable.resend_code(),
                                                   attributes: [.underlineStyle: NSUnderlineStyle.styleSingle.rawValue]))
#endif
        
        self.resendCodeButton.titleLabel?.attributedText = attributedString
        self.resendCodeButton.setTitle(self.resendCodeButton.titleLabel?.text, for: .normal)
        self.resendCodeButton.tintColor = .lightGray
        self.resendCodeButton.titleLabel?.textColor = COLOR_BUTTON_TEXT
        self.resendCodeButton.titleLabel?.adjustsFontSizeToFitWidth = true;
        self.resendCodeButton.titleLabel?.minimumScaleFactor = 0.5;

        self.counterDownLabel.textColor = .white
        self.counterDownLabel.font = APP_FONT_BOLD //UIFont(resource: APP_FONT_BOLD, size: 20)
        self.counterDownLabel.textAlignment = .center
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    func bindingData(){
        if let viewModel = viewModel,let verifyModel = viewModel.verificationCodeModel {
            self.phoneNumberTextField.text = "\(verifyModel.dialCode.value ?? "")" + "\(verifyModel.mobile.value ?? "")"
            verifyCodeTextField.reactive.text.bind(to: verifyModel.verificationCode)
        }
    }
}

// MARK: - IVerificationCodeViewController Protocol
extension VerificationCodeViewController: IVerificationCodeViewController{
    func onSuccessSendVerifyCode() {
        self.showToast(R.string.localizable.success_send_verification_code())
        self.resetCount()
    }
    
    func onSuccessCheckVerifyCode() {
        self.viewModel?.validateCustomer()
    }
    func onSucessValidateCustomer() {
        self.showToast(R.string.localizable.success_activate_account())
        doOnMain(deadline: 1.0, {
            self.dismiss(animated: true, completion: nil)
        })
    }
}
