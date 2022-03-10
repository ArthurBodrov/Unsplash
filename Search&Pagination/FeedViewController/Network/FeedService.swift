//
//  Service.swift
//  Search&Pagination
//
//  Created by Артур Бодров on 10.03.2022.
//

import Foundation
import Alamofire


final class FeedService {
    enum FeedServiceError: Error {
        case photosParsingFailed
    }
   
    let apiManager: APIManager
    let photoParser: PhotoParser
    
    init(apiManager: APIManager = APIManager.shared, photoParser: PhotoParser = PhotoParser()) {
        self.apiManager = apiManager
        self.photoParser = photoParser
    }
    
    
    public func fetchPhotos(handler: @escaping (([Photo]?, Error?) -> Void)) {
        apiManager.call(endpoint: .photos, params: URLConstructor.defaultParams) { [weak self] (_ json: [[String: Any]]?, _ error: Error?)  in
            if let json = json {
                guard let photos: [Photo] = try? self?.photoParser.parse(from: json)
                else { handler(nil, FeedServiceError.photosParsingFailed); return }
                
                handler(photos, nil)
            } else {  handler(nil, error) }
        }
    }
}

