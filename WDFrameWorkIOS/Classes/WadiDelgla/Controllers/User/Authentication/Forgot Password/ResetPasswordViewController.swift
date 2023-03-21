//
//  ResetPasswordViewController.swift
//  STDobites
//
//  Created by SimpleTouch on 10/16/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit

class ResetPasswordViewController: STUIViewController,IBaseController {

    // MARK: - Properties
    typealias T = IResetPasswordViewModel
    var viewModel: IResetPasswordViewModel?
    var countDown = 60

    // MARK: - IBOutlets
    @IBOutlet weak var changePasswordButton: UIButton!
    @IBOutlet weak var counterDownLabel: UILabel!
    @IBOutlet weak var resendCodeButton: UIButton!
    @IBOutlet weak var confirmPasswordTextField: STErrorTextField!
    @IBOutlet weak var passwordTextField: STErrorTextField!
    @IBOutlet weak var verifyCodeTextField: STErrorTextField!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //bind UI
        self.addDismissKeyboardTapGesture()
        self.setupUI()
        self.bindingData()
    }
    // MARK: - IBActions
    
    
    /// This Function called when tapped on resend verify code
    ///
    /// - Parameter sender: resend verify code button
    @IBAction func onResendVerifyCode(_ sender: Any) {
        viewModel?.sendVerifyCode()
    }
    /// This Function called when change password tapped
    ///
    /// - Parameter sender: change password button
    @IBAction func onChangePasswordTapped(_ sender: Any) {
        viewModel?.checkResetPasswordDTO()
    }
    
    @IBAction func onDismissTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Functions
    
    /// This Function to enable or disable resend verify code button
    @objc func updateCounter() {
        if(countDown > 0) {
            self.resendCodeButton.isEnabled = false
            countDown -= 1
            counterDownLabel.text = String(countDown) + " " + R.string.localizable.seconds()
        }else{
            self.resendCodeButton.isEnabled = true
        }
    }
    
    /// This Function to enable resend verify code button
    func resetCount(){
        self.resendCodeButton.isEnabled = false
        self.countDown = 60
    }
    deinit {
        print("deinit Forgot Password reset password")
    }
}

// MARK: - Internal
extension ResetPasswordViewController{
    func setupUI(){
        self.viewModel?.delegate = self
        [self.verifyCodeTextField,self.passwordTextField,self.confirmPasswordTextField].forEach {
            $0?.font = APP_FONT_REGULAR16 //UIFont(resource: APP_FONT_REGULAR, size: 17)
            $0?.textColor = .black
            $0?.setPlaceHolderTextColor(.black)
            
            $0?.backgroundColor = .white
            $0?.layer.cornerRadius = 25
            $0?.addPaddingLeft(16)
            $0?.addPaddingRight(16)

        }
        [self.changePasswordButton].forEach {
            $0?.layer.cornerRadius = 25
            $0?.backgroundColor = COLOR_ACCENT
            
        }
        self.passwordTextField.isSecureTextEntry = true
        self.confirmPasswordTextField.isSecureTextEntry = true
        self.verifyCodeTextField.keyboardType = .numberPad
        
        self.verifyCodeTextField.placeholder = R.string.localizable.verify_code()
        self.passwordTextField.placeholder = R.string.localizable.password()
        self.confirmPasswordTextField.placeholder = R.string.localizable.confirm_password()
        
        self.changePasswordButton.setTitle(R.string.localizable.change_password(), for: .normal)
        
        self.changePasswordButton.titleLabel?.font = FONT_PRIMARY_BUTTON
        
        let attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(string: R.string.localizable.havenT_received_Code(),
                                                   attributes: [.underlineStyle: 0]))
//        attributedString.append(NSAttributedString(string: R.string.localizable.resend_code(),
//                                                   attributes: [.underlineStyle: NSUnderlineStyle.styleSingle.rawValue]))
        
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
        self.resendCodeButton.titleLabel?.sizeToFit()
        
        self.counterDownLabel.textColor = .white
        self.counterDownLabel.font = APP_FONT_BOLD //UIFont(resource: APP_FONT_BOLD, size: 20)
        self.counterDownLabel.textAlignment = .center
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    func bindingData(){
        if let viewModel = viewModel {
            verifyCodeTextField.reactive.text.bind(to: viewModel.verificationCodeModel.verificationCode)
            passwordTextField.reactive.text.bind(to: viewModel.newPasswordModel.password)
            confirmPasswordTextField.reactive.text.bind(to: viewModel.newPasswordModel.confirmPassword)
            verifyCodeTextField.error = viewModel.errorModel.msgVerifyCodeError
            passwordTextField.error = viewModel.errorModel.msgPasswordError
            confirmPasswordTextField.error = viewModel.errorModel.msgConfirmPassowrdError
        }
    }
}

// MARK: - IResetPasswordViewController Protocol
extension ResetPasswordViewController : IResetPasswordViewController{
    func onUpdateLayout() {
        self.bindingData()
    }
    
    /// This Function to show success update password message to user
    func onSuccessUpdatePassword() {
        self.showToast(R.string.localizable.success_update_password())
        doOnMain(deadline: 3.0, {
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    /// this Function to show success send verification code message and reset counter
    func onSuccessSendVerifyCode() {
        self.showToast(R.string.localizable.success_send_verification_code())
        self.resetCount()
    }
    
    func onSuccessCheckVerifyCode() {
         self.viewModel?.changePassword()
    }
}

