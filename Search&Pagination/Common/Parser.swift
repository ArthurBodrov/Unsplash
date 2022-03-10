//
//  Parser.swift
//  Search&Pagination
//
//  Created by Артур Бодров on 08.03.2022.
//

import Foundation

protocol Parser {
    associatedtype Model
    func parse(from dict: [String: Any]) throws -> Model
    func parse(from array: [[String: Any]]) throws -> [Model]
}

extension Parser {
    func parse(from array: [[String: Any]]) throws -> [Model] { return try array.map { try parse(from: $0) } }
}
