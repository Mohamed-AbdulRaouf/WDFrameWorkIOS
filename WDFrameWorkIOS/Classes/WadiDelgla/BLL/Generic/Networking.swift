//
//  Networking.swift
//  Netwroking
//
//  Created by SimpleTouch on 9/22/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Alamofire
public protocol NetworkingBLL {
     func sendRequest(_ apiRoute: URLRequestBuilderBLL, completion: @escaping  onResponse)
    func sendRequest2(_ apiRoute: URLRequestBuilderBLL, completion: @escaping onResponse) 
}
