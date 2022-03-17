//
//  APIManagerMock.swift
//  Search&PaginationTests
//
//  Created by Артур Бодров on 14.03.2022.
//

import Foundation
import PromiseKit
import Alamofire

final class APIManagerMock<U>: APIManager {
    // MARK: - Init
    public private(set) var initDidCall = 0
    public private(set) var initDidSet: Session? = nil
    override init(session: Session) {
        super.init(session: session)
        initDidCall += 1
        initDidSet = session
    }
    
    // MARK: - request<T>
    public private(set) var requestDidCall = 0
    public private(set) var requestDidSet: (endpoint: URLConstructor?, params: Parameters?) = (nil, nil)
    public var requestStub: Promise<U>!
    public override func request<T>(endpoint: URLConstructor, params: Parameters? = nil) -> Promise<T> {
        requestDidCall += 1
        requestDidSet = (endpoint, params)
        return requestStub as! Promise<T>
    }
}
