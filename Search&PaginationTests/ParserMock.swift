//
//  ParserMock.swift
//  Search&PaginationTests
//
//  Created by Артур Бодров on 14.03.2022.
//

import Foundation

final class PhotoParserMock: Parser {
    // MARK: - parseFromArray
    public private(set) var parseFromDictDidCall = 0
    public private(set) var parseFromDictDidSet: [String : Any]? = nil
    public var parseFromDictStub: Photo!
    func parse(fromDict dict: [String : Any]) throws -> Photo {
        parseFromDictDidCall += 1
        parseFromDictDidSet = dict
        return parseFromDictStub
    }
}


final class AnyParserMock<Model>: Parser {
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
