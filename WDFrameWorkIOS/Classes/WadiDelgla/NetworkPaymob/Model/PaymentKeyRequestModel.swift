//
//  PaymentKeyRequestModel.swift
//  TestPods
//
//  Created by Raouf on 27/03/2023.
//

import Foundation

struct PaymentKeyRequestModel : Codable {
    
    let token: String?

    enum CodingKeys: String, CodingKey {

        case token = "token"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        token = try values.decodeIfPresent(String.self, forKey: .token)
    }

}
