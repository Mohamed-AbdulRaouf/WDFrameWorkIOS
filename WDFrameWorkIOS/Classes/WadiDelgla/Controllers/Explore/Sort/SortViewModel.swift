//
//  SortViewModel.swift
//  STDobites
//
//  Created by SimpleTouch on 11/11/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import ReactiveKit
//import DAL
//import BLL
import SVProgressHUD
protocol ISortViewModel: IBaseViewModel {
    var onReloadTable :  (() -> Void)? { get set }
    var model :[IServiceDTODAL]? {get set}
    var delegate : ISortProtocol? {get set}
}
class SortViewModel: ISortViewModel{
    var model :[IServiceDTODAL]? = []
    weak var delegate: ISortProtocol?
    var onReloadTable: (() -> Void)?
    init(){}
    
}
