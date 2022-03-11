//
//  FeedServiceTests.swift
//  Search&PaginationTests
//
//  Created by Артур Бодров on 11.03.2022.
//

import Quick
import Nimble
import PromiseKit

final class FeedServiceTest: QuickSpec {
    override func spec() {
        var service: FeedService!
        
        beforeEach {
            service = FeedService()
        }
        
        describe(".fetchPhotos") {
            
        }
    }
    
}

private extension FeedServiceTest {
    enum TestData {
        static let urlString = "string"
        static let username = "username"
        static let json = [
            [
                "urls": ["regular": urlString],
                "user": ["username": username]
            ],
        ]
    }
}
