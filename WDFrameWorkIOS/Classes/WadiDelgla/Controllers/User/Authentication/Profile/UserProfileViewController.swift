//
//  UserProfileViewController.swift
//  STDobites
//
//  Created by SimpleTouch on 10/20/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
import SwifterSwift
import Bond
//import DAL
import PopupDialog
class UserProfileViewController: STUIViewController,IBaseController {
    
    // MARK: - Properties
    typealias T = IUserProfileViewModel
    var viewModel: IUserProfileViewModel?
    let genderTypes = [R.string.localizable.male(),R.string.localizable.female(),R.string.localizable.specify_later()]
    let pickerView = UIPickerView()
    var isChangePassword = false
    
    // MARK: - IBOutlets
    @IBOutlet weak var userFirstNameTextField: STErrorTextField!
    @IBOutlet weak var userAddressButton: UIButton!
    @IBOutlet weak var changePasswordButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var userGenderTextField: UITextField!
    @IBOutlet weak var userDateOfBirthTextField: UITextField!
    @IBOutlet weak var userPhoneNumberTextField: UITextField!
    @IBOutlet weak var userEmailTextField: STErrorTextField!
    @IBOutlet weak var userLastNameTextField: STErrorTextField!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.addDismissKeyboardTapGesture()
        self.setupUI()
        self.bindingData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //setup navigation buttons
        self.navigationItem.rightBarButtonItem = nil
        self.navigationItem.rightBarButtonItems = nil
        self.navigationItem.setRightBarButton(nil, animated: false)
        
        // initialize data
        viewModel?.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = R.string.localizable.profile()
    }
    
    // MARK: - IBActions
    
    /// This Function to show date picker for birthdate
    ///
    /// - Parameter sender: birthdate textfield
    @IBAction func dp(_ sender: UITextField) {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        if LocalizationSystem.sharedInstance.isCurrentLanguageArabic()
        {
            datePickerView.locale = Locale(identifier: "ar")
        }
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
    }
    
    
    /// this function called when tapped on update user info to call update user in viewmodel
    ///
    /// - Parameter sender: update button
    @IBAction func onUpdateUserTapped(_ sender: Any) {
        viewModel?.updateUser()
    }
    
    /// This function called when change password tapped to show change password popup
    ///
    /// - Parameter sender: change password button
    @IBAction func onChangePasswordTapped(_ sender: Any) {
        // Create a custom view controller
        let changePasswordVC = StoryboardScene.User.changePasswordViewController.instantiate()
        
        // Create the dialog
        let popup = PopupDialog(viewController: changePasswordVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, tapGestureDismissal: true, panGestureDismissal: false) {
            if UserDefaults.user == nil {
                self.isChangePassword = true
                self.openLogin()
            }            
        }
        
        // Present dialog
        present(popup, animated: true, completion: nil)
    }
    
    /// This function called when user address button tapped to open user address viewcontroller
    ///
    /// - Parameter sender: user addresses button
    @IBAction func onUserAddressTapped(_ sender: Any) {
        let vc = StoryboardScene.User.userAddressListViewController.instantiate()
        self.navigationController?.pushViewController(vc)
    }
    
    // MARK: - Functions
    
    /// This Function to set user birthday and user birth month
    ///
    /// - Parameter sender: date picker of birthdate textfield
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        userDateOfBirthTextField.text = dateFormatter.string(from: sender.date)
        self.viewModel?.user_data?.birthday.value = sender.date.day
        self.viewModel?.user_data?.birthmonth.value = sender.date.month
        self.viewModel?.user_data?.birthyear.value = sender.date.year

    }
}

// MARK: - Internal
extension UserProfileViewController{
    func setupUI(){
        self.viewModel?.delegate = self
        self.saveButton.backgroundColor = COLOR_ACCENT
        self.saveButton.layer.cornerRadius = 10
        self.saveButton.layer.borderColor = UIColor.clear.cgColor
        self.saveButton.titleLabel?.font = APP_FONT_BOLD //UIFont(resource: APP_FONT_BOLD, size: 17)
        self.saveButton.setTitle("save".localized(), for: .normal)
        
        [self.userPhoneNumberTextField].forEach {
            $0?.isEnabled = false
        }
        self.changePasswordButton.setTitle(R.string.localizable.change_password(), for: .normal)
        self.userAddressButton.setTitle(R.string.localizable.my_addresses(), for: .normal)
        [self.userAddressButton,self.changePasswordButton].forEach {
            $0?.setTitleColor(COLOR_ACCENT, for: .normal)
            $0?.titleLabel?.font = APP_FONT_BOLD14 //UIFont(resource: APP_FONT_BOLD, size: 14)
            $0?.layer.cornerRadius = 18.2
            // set backgroundColor in order to cover the shadow inside the bounds
            $0?.layer.backgroundColor = UIColor.white.cgColor
            $0?.addShadow(ofColor: .lightGray, radius: 3, offset: CGSize(width: 1, height: 0.5), opacity: 1)
            
        }
        [self.userFirstNameTextField,self.userLastNameTextField,self.userEmailTextField,self.userPhoneNumberTextField,self.userDateOfBirthTextField,self.userGenderTextField].forEach {
            $0?.font = APP_FONT_REGULAR16 //UIFont(resource: APP_FONT_REGULAR, size: 17)
            $0?.textColor = COLOR_PRIMARY_TEXT
            $0?.setPlaceHolderTextColor(COLOR_PRIMARY_TEXT)
            $0?.backgroundColor = .white
            $0?.layer.cornerRadius = 25
            $0?.addPaddingLeft(16)
            $0?.addPaddingRight(16)
            $0?.addShadow(ofColor: .lightGray, radius: 3, offset: CGSize(width: 1, height: 0.5), opacity: 1)
        }
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = .white
        self.userGenderTextField.inputView = pickerView
        self.userFirstNameTextField.placeholder = R.string.localizable.first_name()
        self.userLastNameTextField.placeholder = R.string.localizable.last_name()
        self.userEmailTextField.placeholder = R.string.localizable.email_address()
        self.changePasswordButton.isHidden = true
    }
    func bindingData() {
        if let viewModel = viewModel,let user_data = viewModel.user_data{
            
            user_data.firstName.bidirectionalBind(to: userFirstNameTextField.reactive.text)
            
            user_data.lastName.bidirectionalBind(to: userLastNameTextField.reactive.text)
            
            user_data.email.bidirectionalBind(to: userEmailTextField.reactive.text)
            
            user_data.mobile.bidirectionalBind(to: userPhoneNumberTextField.reactive.text)
            
            if user_data.birthday.value == 0 && user_data.birthmonth.value == 0 {
                self.userDateOfBirthTextField.text = R.string.localizable.date_of_birth()
            }else{
                self.userDateOfBirthTextField.text = "\(user_data.birthday.value ?? 0)/\(user_data.birthmonth.value ?? 0)/\(user_data.birthyear.value ?? 00)"
            }
            self.userDateOfBirthTextField.addTarget(self, action: #selector(dp(_:)), for: .editingDidBegin)
            self.updateGenderLayout(user_data.gender.value ?? GenderTypeDAL.default_gender.rawValue)
            
            userFirstNameTextField.error = viewModel.errorModel?.msgFirstNameError
            userLastNameTextField.error = viewModel.errorModel?.msgLastNameError
            userEmailTextField.error = viewModel.errorModel?.msgEmailError
            
        }
    }
}
// MARK:- This Functions for gender type of user each gender has image 
extension UserProfileViewController : UIPickerViewDataSource, UIPickerViewDelegate{
    //MARK: - Pickerview method
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderTypes.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderTypes[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.userGenderTextField.text = genderTypes[row]
        switch row {
        case 0:
            self.updateGenderLayout(GenderTypeDAL.male.rawValue)
        case 1:
            self.updateGenderLayout(GenderTypeDAL.female.rawValue)
        default:
            self.updateGenderLayout(GenderTypeDAL.default_gender.rawValue)
        }
    }
    func updateGenderLayout(_ gender: String){
        switch gender {
        case GenderTypeDAL.male.rawValue:
            self.viewModel?.user_data?.gender.value = GenderTypeDAL.male.rawValue
            self.userProfileImageView.image = R.image.ic_male()
            self.userGenderTextField.text = genderTypes[0]
        case GenderTypeDAL.female.rawValue:
            self.viewModel?.user_data?.gender.value = GenderTypeDAL.female.rawValue
            self.userProfileImageView.image = R.image.ic_female()
            self.userGenderTextField.text = genderTypes[1]
        default:
            self.viewModel?.user_data?.gender.value = GenderTypeDAL.default_gender.rawValue
            self.userProfileImageView.image = R.image.ic_placeholderUser()
            self.userGenderTextField.text = genderTypes[2]
        }
    }
}

// MARK: - LoginProtocol
extension UserProfileViewController : LoginProtocol{
    func onUserLogedIn() {
        if let _ = UserDefaults.user{
            if isChangePassword{
                isChangePassword = false
                self.tabBarController?.selectedIndex = 0
            }else{
                self.viewModel?.user_data = UserDefaults.user
                self.bindingData()
            }
            
        }else{
            print("navigate to home")
            self.tabBarController?.selectedIndex = 0
        }
    }
    func onDismissLogin() {
        guard UserDefaults.user == nil else { return }
        self.tabBarController?.selectedIndex = 0

    }
}

// MARK: - IUserProfileViewController Protocol
extension UserProfileViewController : IUserProfileViewController{
    func openLogin() {
        let vc = StoryboardScene.User.loginViewController.instantiate()
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    func onUpdateLayout() {
        self.bindingData()
    }
    
    func onUpdateUserSuccessfully() {
        self.showToast(R.string.localizable.success_update_user_profile())
        self.bindingData()
    }
}
