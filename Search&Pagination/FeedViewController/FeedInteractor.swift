//
//  FeedInteractor.swift
//  Search&Pagination
//
//  Created by Артур Бодров on 17.03.2022.
//

import Foundation
import PromiseKit

final class FeedInteractor {
    
    // MARK: - Variables
    let provider: FeedProvider
    let presenter: FeedPresenter
    
    
    // MARK: - Init
    init(provider: FeedProvider, presenter: FeedPresenter) {
        self.provider = provider
        self.presenter = presenter
    }
    
    // MARK: - Functions
    public func fetchPhotos() {
        firstly {
            provider.fetchPhotos()
        }.done { result in
            switch result {
            case .fulfilled(let photos):
                self.presenter.prepareData(models: photos)
            case .rejected(let error):
                self.presenter.prepareError(error)
            }
        }
    }
         
    
    
}
