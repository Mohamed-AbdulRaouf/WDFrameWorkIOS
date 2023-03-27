//
//  User.swift
//  ProjectMVC
//
//  Created by Mohamed Abdul-Raouf on 05/01/2022.
//

import Foundation

struct AuthenticationRequestModel : Codable {
    
    let token: String?
    let detail: String?

    enum CodingKeys: String, CodingKey {

        case token = "token"
        case detail = "detail"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        detail = try values.decodeIfPresent(String.self, forKey: .detail)
    }

}
