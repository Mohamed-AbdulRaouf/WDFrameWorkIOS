//
//  IBaseCollectionCell.swift
//  STDobites
//
//  Created by SimpleTouch on 11/6/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
protocol IBaseCollectionCell:class {
    associatedtype T
    func configureCell(_ model:T)
}
