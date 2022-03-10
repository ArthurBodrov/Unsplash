//
//  File.swift
//  Search&Pagination
//
//  Created by Артур Бодров on 08.03.2022.
//

import Foundation
import UIKit

class PhotoParser: Parser {
    /// TO DO: Make Enums static keys
    
    enum PhotoError: Error {
        case cantParse
    }
    
    func parse(from dict: [String: Any]) throws -> Photo {
        guard
            let urls = dict["urls"] as? [String: Any],
            let photoURLString = urls["regular"] as? String,
            let photoURL = URL(string: photoURLString),
            let photoData = try? Data(contentsOf: photoURL),
            let photo = UIImage(data: photoData),
            let user = dict["user"] as? [String: Any],
            let username = user["username"] as? String
        else { throw PhotoError.cantParse }

        return Photo(photo: photo, username: username)
    }
}
