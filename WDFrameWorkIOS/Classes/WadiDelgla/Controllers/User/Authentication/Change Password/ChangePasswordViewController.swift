//
//  ChangePasswordViewController.swift
//  STDobites
//
//  Created by SimpleTouch on 10/21/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit

class ChangePasswordViewController: STUIViewController,IBaseController {
    
    // MARK: - Properties
    typealias T = IChangePasswordViewModel
    var viewModel: IChangePasswordViewModel?

    // MARK: - IBOutlets
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var confirmPasswordTextField: STErrorTextField!
    @IBOutlet weak var newPasswordTextField: STErrorTextField!
    @IBOutlet weak var oldPasswordTextField: STErrorTextField!

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //bind UI
        self.addDismissKeyboardTapGesture()
        self.setupUI()
        self.bindingData()
    }
    
    // MARK: - IBActions
    @IBAction func onChangePasswordTapped(_ sender: Any) {
        viewModel?.updatePassword()
    }
}

// MARK: - Internal
extension ChangePasswordViewController{
    
    func setupUI(){
        self.viewModel?.delegate = self
        saveButton.backgroundColor = COLOR_ACCENT
        saveButton.titleLabel?.textColor = COLOR_BUTTON_TEXT
        saveButton.titleLabel?.font = FONT_PRIMARY_BUTTON
        headerTitleLabel.font = UIFont(resource: APP_FONT_BOLD, size: 25)
        headerTitleLabel.textColor = COLOR_ACCENT
        [oldPasswordTextField,newPasswordTextField,confirmPasswordTextField].forEach {
            $0?.font = UIFont(resource: APP_FONT_REGULAR, size: 17)
            $0?.underlineTextField(COLOR_PRIMARY_TEXT)
            $0?.setPlaceHolderTextColor(COLOR_PRIMARY_TEXT)
            $0?.textColor = COLOR_PRIMARY_TEXT
            $0?.addPaddingLeft(16)
            $0?.addPaddingRight(16)
        }
        self.oldPasswordTextField.placeholder = R.string.localizable.old_password()
        self.newPasswordTextField.placeholder = R.string.localizable.new_password()
        self.confirmPasswordTextField.placeholder = R.string.localizable.confirm_password()
        self.saveButton.setTitle(R.string.localizable.save(), for: .normal)
        headerTitleLabel.text = R.string.localizable.change_password()
    }
    
    func bindingData() {
        if let viewModel = viewModel,let passwordModel = viewModel.passwordModel {
            oldPasswordTextField.reactive.text.bind(to: passwordModel.oldPassword)
            newPasswordTextField.reactive.text.bind(to: passwordModel.newPassword)
            confirmPasswordTextField.reactive.text.bind(to: passwordModel.confirmPassword)
            oldPasswordTextField.error = viewModel.errorModel?.msgOldPasswordError
            newPasswordTextField.error = viewModel.errorModel?.msgNewPasswordError
            confirmPasswordTextField.error = viewModel.errorModel?.msgConfirmPasswordError
        }
    }
}

// MARK: - IChangePasswordViewController Protocol
extension ChangePasswordViewController: IChangePasswordViewController{
    func onUpdateLayout() {
        self.bindingData()
    }
    
    func onUpdatePasswordSuccess() {
        self.showToast(R.string.localizable.success_update_password())
        doOnMain(deadline: 1.0, {
            self.dismiss(animated: true, completion: nil)
        })
    }
}
