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
    // MARK: - Errors
    enum FeedServiceError: Error {
        case parseError
    }
   
    // MARK: - Variables
    private let apiManager: APIManager
    private let photoParser: AnyParser<Photo>
    
    // MARK: - Init
    init(apiManager: APIManager = APIManager.shared, photoParser: AnyParser<Photo> = AnyParser(PhotoParser())) {
        self.apiManager = apiManager
        self.photoParser = photoParser
    }
    
    // MARK: - Public Methods
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
    }
}
