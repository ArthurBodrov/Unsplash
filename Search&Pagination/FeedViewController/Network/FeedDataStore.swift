//
//  FeedDataStore.swift
//  Search&Pagination
//
//  Created by Артур Бодров on 10.03.2022.
//

import Foundation

final class FeedDataStore {
    private var store: [Photo] = []
    
    var isEmpty: Bool { store.isEmpty }
    
    public func fulfill(photos: [Photo]) {
        store = photos
    }
    
    public func get() -> [Photo] {
        return store
    }
}
