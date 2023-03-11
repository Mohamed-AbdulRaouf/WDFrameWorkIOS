//
//  ChangePasswordViewModel.swift
//  STDobites
//
//  Created by SimpleTouch on 10/21/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
//import DAL
//import BLL
protocol IChangePasswordViewModel: IBaseViewModel {
    
    var passwordModel : INewPasswordDTODAL? {get set}
    var apiClient: UserServiceBLL? { get set }
    var errorModel : IChangePasswordValidationDTOBLL? {get set}
    func updatePassword()
    var delegate: IChangePasswordViewController? {get set}
    
}
class ChangePasswordViewModel: IChangePasswordViewModel{
    
    weak var delegate: IChangePasswordViewController?
    
    var passwordModel: INewPasswordDTODAL?
    
    var apiClient: UserServiceBLL?
    
    var errorModel: IChangePasswordValidationDTOBLL?
    
    
    
    public  init (newPasswordModel : INewPasswordDTODAL ,apiClient: UserServiceBLL,errorModel : IChangePasswordValidationDTOBLL){
        self.passwordModel = newPasswordModel
        self.errorModel = errorModel
        self.apiClient = apiClient
        self.viewDidLoad()
    }
    func viewDidLoad(){
         self.passwordModel?.currentPassword.value = UserDefaults.user?.password.value ?? ""
    }
    /// This Function to update user password with new one
    func updatePassword(){
        self.showHud()
        doInBackground {
            self.apiClient?.updatePassword(self.passwordModel!,0) { (response) in
                doOnMain {
                    self.hideHUD()
                    guard let _ = response?.data else {
                        self.errorModel = response?.error?.validateError as? IChangePasswordValidationDTOBLL
                        self.delegate?.onUpdateLayout()
                        if response?.error?.APIError != nil {
                            self.delegate?.onError(response?.error?.APIError?.description ?? "")
                        }
                        if response?.error?.networkError != nil {
                            self.delegate?.onError(response?.error?.networkError?.description ?? "")
                        }
                        return
                    }
                    //update password offline
                    /*
                    self.viewDidLoad()
                    let user = UserDefaults.user
                    user?.password.value = self.passwordModel?.newPassword.value
                    UserDefaults.user = user
                    */
                    UserDefaults.user = nil
                    UserDefaults.loginData = nil
                    self.delegate?.onUpdatePasswordSuccess()
                }
            }
        }
    }
}

