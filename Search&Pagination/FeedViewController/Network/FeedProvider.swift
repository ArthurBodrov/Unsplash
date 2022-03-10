//
//  FeedProvider.swift
//  Search&Pagination
//
//  Created by Артур Бодров on 10.03.2022.
//

import Foundation

final class FeedProvider {
    private let service: FeedService
    private let dataStore: FeedDataStore
    
    init(service: FeedService = FeedService(), dataStore: FeedDataStore = FeedDataStore()) {
        self.service = service
        self.dataStore = dataStore
    }
    
    public func fetchPhotos(handler: @escaping ([Photo]?, Error?) -> Void) {
        guard dataStore.isEmpty else { handler(dataStore.get(), nil); return }

        service.fetchPhotos { [weak self] photos, error in
            if let photos = photos {
                self?.dataStore.fulfill(photos: photos)
                handler(photos, nil)
            } else {
                handler(nil, error)
            }
        }
    }
}
