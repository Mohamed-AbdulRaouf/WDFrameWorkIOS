//
//  IBaseTableViewCell.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 10/28/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
protocol IBaseTableViewCell:class {
    associatedtype T

    func configureCell(_ model:T)
}
