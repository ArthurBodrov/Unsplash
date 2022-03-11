//
//  Parser.swift
//  Search&Pagination
//
//  Created by Артур Бодров on 08.03.2022.
//

import Foundation

protocol Parser {
    associatedtype Model
    func parse(fromDict dict: [String: Any]) throws -> Model
    func parse(fromArray array: [[String: Any]]) throws -> [Model]
}

extension Parser {
    func parse(fromArray array: [[String: Any]]) throws -> [Model] { return try array.map { try parse(fromDict: $0) } }
}
