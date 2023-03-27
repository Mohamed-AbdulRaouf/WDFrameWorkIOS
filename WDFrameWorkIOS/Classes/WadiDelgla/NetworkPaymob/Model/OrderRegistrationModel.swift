//
//  OrderRegistrationModel.swift
//  TestPods
//
//  Created by Raouf on 27/03/2023.
//

import Foundation

struct OrderRegistrationModel : Codable {
    
    let id: Int?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
    }
    
}

