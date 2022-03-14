//
//  Photos.swift
//  Search&Pagination
//
//  Created by Артур Бодров on 08.03.2022.
//

import UIKit

/// Struct of Photo Element
struct Photo {
    /// "regular" photo URLs as String
    let photo: UIImage
    /// Username
    let username: String
    
    
//    enum CodingKeys: String, CodingKey {
//        case urls = "urls"
//        case user = "user"
//    }
//    
//    enum UrlsCodingKeys: String, CodingKey {
//        case regular
//    }
//    
//    enum UsernameCodingKeys: String, CodingKey {
//        case username
//    }
}

//
//extension Photo: Decodable {
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        let urls = try values.nestedContainer(keyedBy: UrlsCodingKeys.self, forKey: .urls)
//        let usernameValues = try values.nestedContainer(keyedBy: UsernameCodingKeys.self, forKey: .user)
//
//        photoURLString = try urls.decode(String.self, forKey: .regular)
//        username = try usernameValues.decode(String.self, forKey: .username)
//    }
//}
