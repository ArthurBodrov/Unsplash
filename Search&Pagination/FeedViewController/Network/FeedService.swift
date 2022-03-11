//
//  Service.swift
//  Search&Pagination
//
//  Created by Артур Бодров on 10.03.2022.
//

import Foundation
import Alamofire
import PromiseKit


final class FeedService {
    enum FeedServiceError: Error {
        case jsonParsingFailed
    }
   
    private let apiManager: APIManager
    private let photoParser: PhotoParser
    
    init(apiManager: APIManager = APIManager.shared, photoParser: PhotoParser = PhotoParser()) {
        self.apiManager = apiManager
        self.photoParser = photoParser
    }
    
    
    public func fetchPhotos() -> Promise<[Photo]> {
        
        let request: Promise<Data> = apiManager.request(endpoint: .photos, params: URLConstructor.defaultParams)
        
        firstly {
            request
        }.then { data -> Thenable[[String:Any]] in
            let json = try JSONSerialization.jsonObject(with: data, options: []) as [[String:Any]]
            return json
        }
//        .then { json -> [Photo] in
//            return try self.photoParser.parse(fromArray: json)
//        }
        
        
        
        
//        return Promise { [weak self] seal in
//            guard
//                let self = self,
//                let result = self.apiManager.call(endpoint: .photos, params: URLConstructor.defaultParams)
//                                                            as? Promise<[[String: Any]]>,
//                let json = result.result
//            else { return seal.reject(FeedServiceError.jsonParsingFailed) }
//
//            switch json {
//            case .fulfilled(let value):
//                seal.fulfill(try self.photoParser.parse(fromArray: value))
//            case .rejected(let error):
//                seal.reject(error)
//            }
//        }
    }
}

