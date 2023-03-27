//
//  BaseCodable.swift
//  ProjectMVC
//
//  Created by Mohamed Abdul-Raouf on 05/01/2022.
//

import Foundation

protocol BaseCodable: Codable {
    var errors: [BaseError]? { get set }
    var meta: Meta? { get set }
}

struct BaseModel: BaseCodable {
    var errors: [BaseError]?
    var meta: Meta?
}

struct BaseModelWithData<T: Codable>: BaseCodable {
    var errors: [BaseError]?
    var meta: Meta?
    var data: T?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        errors = try? container.decode([BaseError].self, forKey: .errors)
        meta = try? container.decode(Meta.self, forKey: .meta)
        data = try? container.decode(T.self, forKey: .data)
    }
}

// MARK: - Meta
struct Meta: Codable {
    let message: String?
    let token: String?
    let pagination: Pagination?
}

// MARK: - Pagination
struct Pagination: Codable {
    let totalPages, count, lastPage: Int?
    let perPage, currentPage, total: Int

    enum CodingKeys: String, CodingKey {
        case totalPages = "total_pages"
        case count
        case perPage = "per_page"
        case currentPage = "current_page"
        case total
        case lastPage = "last_page"
    }
}

// MARK: - Error
struct BaseError: Codable {
    let title: String?
    let status: Int?
    var detail: String?
}
