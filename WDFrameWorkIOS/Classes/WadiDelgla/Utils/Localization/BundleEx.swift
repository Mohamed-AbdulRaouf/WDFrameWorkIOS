//
//  BundleEx.swift
//  ChangeDirection
//
//  Created by inJaz on 5/12/19.
//  Copyright © 2019 injaz. All rights reserved.
//

import Foundation

//A key used for exchanging associated object
var _BUNDLE_KEY = 0

class BundleEx : Bundle {
    
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        
        let bundle : Bundle? = objc_getAssociatedObject(self, &_BUNDLE_KEY) as? Bundle
        
        return bundle != nil ? bundle!.localizedString(forKey: key, value: value, table: tableName) : super.localizedString(forKey: key, value: value, table: tableName)
    }
}
