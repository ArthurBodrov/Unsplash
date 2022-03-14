//
//  ViewController.swift
//  Search&Pagination
//
//  Created by Артур Бодров on 08.03.2022.
//

import UIKit
import SnapKit
import Alamofire
import PromiseKit

final class FeedViewController: UIViewController {
    // MARK: - Variables
    private var photos: [Photo] = []
    
    private lazy var collectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionView =  UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.register(FeedCollectionViewCell.self, forCellWithReuseIdentifier: FeedCollectionViewCell.identifier)
        return collectionView
    }()
    
    lazy var service = FeedService()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = collectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        firstly {
            service.fetchPhotos()
        }.done { [weak self] photos in
            self?.photos = photos
//            DispatchQueue.main.async {
               self?.collectionView.reloadData()
               print("reloaded Data")
//           }
            return
        }.catch { error in
            print(error)
        }
        
        
//        provider.fetchPhotos { [weak self] photos, error  in
//            guard let photos = photos else { print(error); return }
//            self?.photos = photos
//            DispatchQueue.main.async {
//               self?.collectionView.reloadData()
//               print("reloaded Data")
//           }
//        }

        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// Delegate & Data Source
extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCollectionViewCell.identifier, for: indexPath) as? FeedCollectionViewCell
        else { return UICollectionViewCell() }
        cell.setupCell(with: photos[indexPath.row])

        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 400, height: 300)
    }
}
