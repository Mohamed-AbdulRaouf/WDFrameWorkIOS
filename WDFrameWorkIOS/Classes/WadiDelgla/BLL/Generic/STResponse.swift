//
//  STResponse.swift
//  BLL
//
//  Created by SimpleTouch on 10/10/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
public class STResponseBLL {
    public var data : Any?
    public var error : STErrorBLL?
    init(data: Any?,error : STErrorBLL?) {
        self.data = data
        self.error = error
    }
}
