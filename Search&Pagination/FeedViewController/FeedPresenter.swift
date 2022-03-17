//
//  FeedPresenter.swift
//  Search&Pagination
//
//  Created by Артур Бодров on 17.03.2022.
//

import Foundation
import UIKit

final class FeedPresenter {
    typealias ViewModel = FeedCollectionViewModel
    // MARK: - Variables
    weak var viewController: FeedViewController?
        
    // MARK: - Functions
    public func prepareData(models: [Photo]) {
        let viewModels: [ViewModel] = models.compactMap { photo in
            guard
                let url = URL(string: photo.photoURLString),
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data)
                else { return nil }
            
            return .init(username: photo.username, image: image)
        }
        viewController?.displayPhotos(viewModels)
    }
    
    public func prepareError(_ error: Error) {
        viewController?.displayError(error)
    }
    
    public func setViewController(_ viewController: FeedViewController) {
        self.viewController = viewController
    }
}
