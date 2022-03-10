//
//  URLConctructor.swift
//  Search&Pagination
//
//  Created by Артур Бодров on 09.03.2022.
//

import Foundation
import Alamofire

public enum URLConstructor {
    case photos

    public static var defaultParams: Parameters { return ["client_id": "17fRQ3Tx7HGP8hQ52Dy-obCBiZQzd868-YtGMxa99UA"] }
}

public extension URLConstructor {
    var base: String {
        switch self {
        default:
            return "https://api.unsplash.com"
        }
    }
    
    var path: String {
        switch self {
        case .photos:
            return "/photos/"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .photos:
            return .get
        default:
            return .get
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        default:
            return JSONEncoding.default
        }
    }
    
    var fullUrlString: String {
        switch self {
        default:
            return self.base + self.path
        }
    }
}
