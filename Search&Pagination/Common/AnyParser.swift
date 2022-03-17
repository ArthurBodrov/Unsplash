//
//  AnyParser.swift
//  Search&Pagination
//
//  Created by Артур Бодров on 15.03.2022.
//

import Foundation

/// Closure Type Erasure
final class AnyParser<Model>: Parser {
    let _parserFromDict: ([String: Any]) throws -> Model
    let _parserFromArray: ([[String: Any]]) throws -> [Model]
    
    init<T: Parser>(_ parser: T) where T.Model == Model {
        self._parserFromDict = parser.parse(fromDict:)
        self._parserFromArray = parser.parse(fromArray:)
    }
    
    func parse(fromDict dict: [String : Any]) throws -> Model {
        return try _parserFromDict(dict)
    }

    func parse(fromArray array: [[String : Any]]) throws -> [Model] {
        return try _parserFromArray(array)
    }
}
