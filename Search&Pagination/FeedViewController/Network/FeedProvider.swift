//
//  FeedProvider.swift
//  Search&Pagination
//
//  Created by Артур Бодров on 10.03.2022.
//

import Foundation
import PromiseKit

final class FeedProvider {
    // MARK: - Variables
    private let service: FeedService
    private let dataStore: FeedDataStore
    
    // MARK: - Init
    init(service: FeedService = FeedService(), dataStore: FeedDataStore = FeedDataStore()) {
        self.service = service
        self.dataStore = dataStore
    }
    
    
    // MARK: - Public Methods
    public func fetchPhotos() -> Guarantee<Result<[Photo]>> {
        return Guarantee { resolver in
            firstly {
                service.fetchPhotos()
            }.done { [weak self] result in
                switch result {
                case .fulfilled(let photos):
                    self?.dataStore.fulfill(photos: photos)
                    return resolver(.fulfilled(photos))
                case .rejected(let error):
                    resolver(.rejected(error))
                }
            }
        }
    }
}
