//
//  FeedProvider.swift
//  Search&Pagination
//
//  Created by Артур Бодров on 10.03.2022.
//

import Foundation
import PromiseKit
//
//final class FeedProvider {
//    private let service: FeedService
//    private let dataStore: FeedDataStore
//    
//    init(service: FeedService = FeedService(), dataStore: FeedDataStore = FeedDataStore()) {
//        self.service = service
//        self.dataStore = dataStore
//    }
//    
//    // Guarantee<[Photo]>
//    public func fetchPhotos() -> Promise<[Photo]> {
//        return firstly {
//            service.fetchPhotos()
//        }.then { [weak self] photos -> Promise<[Photo]> in
//            self?.dataStore.fulfill(photos: photos)
//            return Promise.value(photos)
//        }
////        .catch { error in
////            Promise<[Photo]>(error: error)
////        }
//        
//        
////        return service.fetchPhotos().done { photos in
////            dataStore.fulfill(photos: photos)
////        }.
//
////        firstly {
////            service.fetchPhotos()
////        }.done {
////            dataStore.fulfill(photos: $0)
////        }
////
//        
//        
////        service.fetchPhotos { [weak self] photos, error in
////            if let photos = photos {
////                self?.dataStore.fulfill(photos: photos)
////                handler(photos, nil)
////            } else {
////                handler(nil, error)
////            }
////        }
//    }
//}
