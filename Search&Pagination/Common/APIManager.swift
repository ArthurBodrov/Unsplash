//
//  NetworkManager.swift
//  Search&Pagination
//
//  Created by Артур Бодров on 08.03.2022.
//

import Alamofire
import Foundation

public final class APIManager {
    // MARK: - Variables
    private let session: Session
    
    public static var shared: APIManager = { return APIManager(session: Session()) }()
    
    // MARK: - Initialization
    init(session: Session) {
        self.session = session
    }
    
    // MARK: - Functions
    
    public func call<T>(endpoint: URLConstructor, params: Parameters? = nil, handler: @escaping ((T?, AFError?) -> Void)) {
        self.session.request(
            endpoint.fullUrlString,
            method: endpoint.httpMethod,
            parameters: params
        ).validate().response { response in
            switch response.result {
            case .success(let value):
                guard let data = value,
                      let json = try? JSONSerialization.jsonObject(with: data, options: []) as? T
                else { handler(nil, AFError.responseSerializationFailed(reason: .inputFileNil)); return }
                handler(json, nil)
            case .failure(_):
                handler(nil, response.error)
            }
        }
    }
    
}
