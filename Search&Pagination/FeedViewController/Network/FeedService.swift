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
        case parseError
    }
   
    private let apiManager: APIManager
    private let photoParser: PhotoParser
    
    init(apiManager: APIManager = APIManager.shared, photoParser: PhotoParser = PhotoParser()) {
        self.apiManager = apiManager
        self.photoParser = photoParser
    }
    
    
    public func fetchPhotos() -> Guarantee<Result<[Photo]>> {
        return Guarantee { resolver in
            firstly {
                apiManager.request(endpoint: .photos, params: URLConstructor.defaultParams) as Promise<[[String: Any]]>
            }.done { [weak self] array in
                guard let photos = try self?.photoParser.parse(fromArray: array)
                    else { return resolver(.rejected(FeedServiceError.parseError))}
                resolver(.fulfilled(photos))
            }.catch { error in
                resolver(.rejected(error))
            }
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
