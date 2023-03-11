//
//  OrderTypeViewModel.swift
//  SimpleTouch
//
//  Created by SimpleTouch on 9/28/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
//import DAL
protocol IOrderTypeProtocol:class {
    func didSelectOrderType(_ orderTypeId: Int)
}
protocol IOrderTypeViewModel {
    var delegate: IOrderTypeViewController? {get set}
    var orderTypeDelegate: IOrderTypeProtocol? {get set}
     var orderTypeModel: [IOrderTypeDTODAL]? {get set}
    func viewDidLoad()
    
}
class OrderTypeViewModel:IOrderTypeViewModel {
    weak var delegate: IOrderTypeViewController?
    weak var orderTypeDelegate: IOrderTypeProtocol?
    var orderTypeModel: [IOrderTypeDTODAL]? = []
    public init(){}
    func viewDidLoad() {
        self.loadData()
    }
    func loadData() {
        
        orderTypeModel?.append(OrderType.online.instance)
        orderTypeModel?.append(OrderType.atStore.instance)
//        orderTypeModel?.append(OrderType.dine_in.instance)
//        orderTypeModel?.append(OrderType.drive_thrue.instance)
//        orderTypeModel?.append(OrderType.delivery.instance)
        self.delegate?.onReloadCollectionView()
    }
}
