//
//  FilterationViewModel.swift
//  STDobites
//
//  Created by SimpleTouch on 11/11/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import ReactiveKit
import SVProgressHUD

protocol IFilterationViewModel: IBaseViewModel {
    var onReloadTable :  (() -> Void)? { get set }
    var filterationList :IFilterationListDTODAL? {get set}
    var selectedFacilities: [String]? {get set}
    var selectedCuisine: [String]? {get set}
    var delegate: IFilterProtocol? {get set}
    func setSelectedFacilitiesAndCuisies()
    var model : [IFilterationSectionDTODAL]? {get set}
    func viewDidLoad()
}
class FilterationViewModel: IFilterationViewModel{
    var model: [IFilterationSectionDTODAL]? = []
    weak var delegate: IFilterProtocol?
    var onReloadTable: (() -> Void)?
    var filterationList :IFilterationListDTODAL?
    var selectedCuisine: [String]?
    var selectedFacilities: [String]?
    public  init (){}
    func viewDidLoad(){
        model?.append(FilterationSectionDTODAL(title: R.string.localizable.cuisine_filter(),type: "C", items: filterationList?.cuisineList.value ?? []))
        model?.append(FilterationSectionDTODAL(title: R.string.localizable.facilites_filter(),type: "F", items: filterationList?.faciltyList.value ?? []))
        selectedCuisine = UserDefaults.recentCuisineFilterSearches ?? []
        if let items = model?.first(where: {$0.type.value == "C"})?.items.value {
            for item in items{
                item.isSelected.value = self.selectedCuisine?.contains(String(item.id.value ?? 0))
            }
        }
        selectedFacilities = UserDefaults.recentFaciltiesFilterSearches ?? []
        if let items = model?.first(where: {$0.type.value == "F"})?.items.value  {
            for item in items{
                item.isSelected.value = self.selectedFacilities?.contains(String(item.id.value ?? 0))
            }
        }
    }
    
    func setSelectedFacilitiesAndCuisies(){
        if self.delegate != nil {
            //cuisines
            let selectedC = model?.first(where: {$0.type.value == "C"})?.items.value?.filter({$0.isSelected.value!})
            selectedCuisine = []
            if let selectedC = selectedC {
                for item in selectedC {
                    selectedCuisine?.append(String(item.id.value ?? 0))
                }
            }
            //facilities
            let selectedF = model?.first(where: {$0.type.value == "F"})?.items.value?.filter({$0.isSelected.value!})
            selectedFacilities = []
            if let selectedF = selectedF {
                for item in selectedF {
                    selectedFacilities?.append(String(item.id.value ?? 0))
                }
            }
            self.delegate?.setSelectedFacilityAndCusinies(self.selectedCuisine ?? [], self.selectedFacilities ?? [])
        }
    }
    
}
