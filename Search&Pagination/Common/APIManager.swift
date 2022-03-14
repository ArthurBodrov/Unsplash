//
//  NetworkManager.swift
//  Search&Pagination
//
//  Created by Артур Бодров on 08.03.2022.
//

import Alamofire
import Foundation
import PromiseKit

public final class APIManager {
    // MARK: - Errors
    enum APIManagerError: Error {
        case dontHaveData
    }
    
    // MARK: - Variables
    private let session: Session
    
    public static var shared: APIManager = { return APIManager(session: Session()) }()
    
    // MARK: - Initialization
    init(session: Session) {
        self.session = session
    }
    
    // MARK: - Functions
    // TODO: return completionHandler?
    public func request<T>(endpoint: URLConstructor, params: Parameters? = nil) -> Promise<T> {
        
        // responseDecodable
        return Promise<T> { seal in
            self.session.request(
                endpoint.fullUrlString,
                method: endpoint.httpMethod,
                parameters: params
            ).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    guard let data = value as? T else { return seal.reject(APIManagerError.dontHaveData) }
                    return seal.fulfill(data)
                case .failure(let error):
                    return seal.reject(error)
                }
            }
        }
    }
}
