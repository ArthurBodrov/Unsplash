//
//  FeedDataStore.swift
//  Search&Pagination
//
//  Created by Артур Бодров on 10.03.2022.
//

import Foundation

final class FeedDataStore {
    // MARK: - Variables
    private var store: [Photo] = []
    public var isEmpty: Bool { store.isEmpty }
    
    // MARK: - Functions
    public func fulfill(photos: [Photo]) {
        store += photos
    }
    
    public func get() -> [Photo] {
        return store
    }
}
