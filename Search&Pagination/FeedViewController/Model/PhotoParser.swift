//
//  File.swift
//  Search&Pagination
//
//  Created by Артур Бодров on 08.03.2022.
//

import Foundation
import UIKit

final class PhotoParser: Parser {
    enum PhotoParserKeys: String {
        case urls
        case regular
        case user
        case username
    }
    
    enum PhotoError: Error {
        case cantParse
    }
    
    func parse(fromDict dict: [String: Any]) throws -> Photo {
        guard
            let urls = dict[PhotoParserKeys.urls.rawValue] as? [String: Any],
            let photoURLString = urls[PhotoParserKeys.regular.rawValue] as? String,
            let user = dict[PhotoParserKeys.user.rawValue] as? [String: Any],
            let username = user[PhotoParserKeys.username.rawValue] as? String
        else { throw PhotoError.cantParse }

        return Photo(photoURLString: photoURLString, username: username)
    }
}
