//
//  FeedServiceTests.swift
//  Search&PaginationTests
//
//  Created by Артур Бодров on 11.03.2022.
//

import Quick
import Nimble
import PromiseKit
import Alamofire
import Combine
@testable import Search_Pagination

final class FeedServiceTest: QuickSpec {
    override func spec() {
        var service: FeedService!
        var parserErasureMock: AnyParser<Photo>!
        var photoParserMock: PhotoParserMock!
        var apiManagerMock: APIManagerMock<[[String: Any]]>!
        
        beforeEach {
            apiManagerMock = APIManagerMock(session: Session())
            photoParserMock = PhotoParserMock()
            parserErasureMock = AnyParser(photoParserMock)
            service = FeedService(apiManager: apiManagerMock, photoParser: parserErasureMock)
        }
        
        describe(".fetchPhotos") {
            context("success") {
                it("should give right value") {
                    // when
                    photoParserMock.parseFromDictStub = TestData.model
                    apiManagerMock.requestStub = .value(TestData.json)
                    let promise = service.fetchPhotos()
                    
                    // then
                    expect(apiManagerMock.initDidCall).to(equal(1))
//                    expect(apiManagerMock.initDidSet).to(equal(session))
                    expect(photoParserMock.parseFromDictDidCall).to(equal(1))
                    expect((photoParserMock.parseFromDictDidSet!["urls"] as? [String: String])?["regular"]).to(equal(TestData.urlString))
                    expect((photoParserMock.parseFromDictDidSet!["user"]as? [String: String])?["username"]).to(equal(TestData.username))
                    
//                    expect(promise.value).to(equal(TestData.model))
                    
                }
            }

            context("failure") {
                
            }
        }
    }
    
}

private extension FeedServiceTest {
    enum TestData {
        static let urlString = "heart.fill"
        static let username = "username"
        static let json: [[String: String]] = [
            [
                "urls": ["regular": urlString],
                "user": ["username": username]
            ],
        ]
        static let photoImage = UIImage(systemName: "heart.fill")!
        static let model = Photo(photo: photoImage, username: username)
    }
}

//extension Dictionary: Equatable where Key == String, Value == Any {
//    
//}
