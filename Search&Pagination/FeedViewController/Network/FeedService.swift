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
    
    
    public func fetchPhotos() -> [Photo] {
        firstly {
            self.apiManager.request(endpoint: .photos, params: URLConstructor.defaultParams)
             as Promise<[[String: Any]]>
        }
        
        

//        return Promise { [weak self] seal in
//
//            firstly {
//                self.apiManager.request(endpoint: .photos, params: URLConstructor.defaultParams)
//                 as Promise<[[String: Any]]>
//            }
//
//            guard
//                let self = self,
//                let result = self.apiManager.request(endpoint: .photos, params: URLConstructor.defaultParams)
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
