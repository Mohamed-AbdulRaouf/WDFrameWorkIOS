//
//  UserProfileViewModel.swift
//  STDobites
//
//  Created by SimpleTouch on 10/21/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
//import DAL
//import BLL
protocol IUserProfileViewModel: IBaseViewModel {
    
    var user_data : IUserDTODAL? {get set}
    var apiClient: UserServiceBLL? { get set }
    var errorModel : IUserProfileValidationDTOBLL? {get set}
        
    func viewDidLoad()
    func updateUser()
    var delegate: IUserProfileViewController? {get set}

}
class UserProfileViewModel: IUserProfileViewModel{
    weak var delegate: IUserProfileViewController?
    
    var user_data: IUserDTODAL?
    
    var apiClient: UserServiceBLL?
    
    var errorModel: IUserProfileValidationDTOBLL?

    public  init (user_data : IUserDTODAL,apiClient: UserServiceBLL,errorModel : IUserProfileValidationDTOBLL){
        self.user_data = user_data
        self.errorModel = errorModel
        self.apiClient = apiClient
    }
    /// This Function to update user information
    func updateUser(){
        self.showHud()
        doInBackground {
            self.apiClient?.updateUser(self.user_data!) { (response) in
                doOnMain {
                    self.hideHUD()
                    guard let _ = response?.data else {
                        self.errorModel = response?.error?.validateError as? IUserProfileValidationDTOBLL
                        self.delegate?.onUpdateLayout()
                        if response?.error?.APIError != nil {
                            self.delegate?.onError(response?.error?.APIError?.description ?? "")
                        }
                        if response?.error?.networkError != nil {
                            self.delegate?.onError(response?.error?.networkError?.description ?? "")
                        }
                        return
                    }
                    UserDefaults.user = self.user_data as? UserDTODAL
                    self.delegate?.onUpdateUserSuccessfully()
                }
               
            }
        }
    }
    /// This Function to check if user login ot not to load user info
    func viewDidLoad(){
        if let user = UserDefaults.user {
            self.user_data = user
            self.delegate?.onUpdateLayout()
        }else{
            self.delegate?.openLogin()
        }
    }
    
}
