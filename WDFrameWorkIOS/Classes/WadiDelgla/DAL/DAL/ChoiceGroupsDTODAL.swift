//
//  ChoiceGroupsDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/13/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import SwiftyJSON
public  class ChoiceGroupsDTODAL : IChoiceGroupsDTODAL{
    
    public var choiceGroupId: Observable<Int?> = Observable<Int?>(nil)
    
    public var choiceGroupTitle: Observable<String?> = Observable<String?>(nil)
    
    public var minChoiceSelected: Observable<Int?> = Observable<Int?>(nil)
    
    public var maxChoiceSelected: Observable<Int?> = Observable<Int?>(nil)
    
    public var itemSizeID: Observable<Int?> = Observable<Int?>(nil)
 
    public var isSelectedMinMax: Observable<Bool?> = Observable<Bool?>(nil)
    
    public var choices: Observable<[IChoiceDTODAL]?> = Observable<[IChoiceDTODAL]?>(nil)

    public var collapsed: Observable<Bool?> = Observable<Bool?>(nil)
    
    public init(){}
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case Title = "Title"
        case MinChoiceSelected = "MinChoiceSelected"
        case MaxChoiceSelected = "MaxChoiceSelected"
        case ItemSizeID = "ItemSizeID"
        case Choices = "Choices"
    }
    public init(json: JSON)  {
        self.choiceGroupId.value = json[CodingKeys.id.rawValue].intValue
        self.choiceGroupTitle.value =  json[CodingKeys.Title.rawValue].stringValue
        self.minChoiceSelected.value = json[CodingKeys.MinChoiceSelected.rawValue].intValue
        self.maxChoiceSelected.value = json[CodingKeys.MaxChoiceSelected.rawValue].intValue
        self.itemSizeID.value = json[CodingKeys.ItemSizeID.rawValue].intValue
        self.isSelectedMinMax.value = false
        self.choices.value = json[CodingKeys.Choices.rawValue].arrayValue.map({try! ChoiceDTODAL.init(json: $0)})
        self.collapsed.value = false
    }
    public init(choiceGroupId: Int?,choiceGroupTitle: String?,minChoiceSelected: Int?,maxChoiceSelected: Int?,itemSizeID: Int?,isSelectedMinMax: Bool?,choices: [IChoiceDTODAL]? ,collapsed: Bool?){
        self.choiceGroupId.value = choiceGroupId
        self.choiceGroupTitle.value =  choiceGroupTitle
        self.minChoiceSelected.value = minChoiceSelected
        self.maxChoiceSelected.value = maxChoiceSelected
        self.itemSizeID.value = itemSizeID
        self.isSelectedMinMax.value = isSelectedMinMax
        self.choices.value = choices
        self.collapsed.value = collapsed
    }
    
    public  func copy() -> Any{
        let copy = ChoiceGroupsDTODAL(choiceGroupId: choiceGroupId.value, choiceGroupTitle: choiceGroupTitle.value, minChoiceSelected: minChoiceSelected.value, maxChoiceSelected: maxChoiceSelected.value, itemSizeID: itemSizeID.value, isSelectedMinMax: isSelectedMinMax.value, choices: choices.value?.map({$0.copy() as! IChoiceDTODAL}),collapsed: collapsed.value)
        return copy
    }
    
}
