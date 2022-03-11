//
//  ViewController.swift
//  Search&Pagination
//
//  Created by Артур Бодров on 08.03.2022.
//

import UIKit
import SnapKit
import Alamofire

final class FeedViewController: UIViewController {
    // MARK: - Variables
    private var photos: [Photo] = []
    
    private lazy var collectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionView =  UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.register(FeedCollectionViewCell.self, forCellWithReuseIdentifier: FeedCollectionViewCell.identifier)
        return collectionView
    }()

    private lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(frame: .zero)
        return loader
    }()
    
    lazy var provider = FeedProvider()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = collectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addSubviews()
        makeConstraints()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        loader.startAnimating()
        displayPhotos()
    }
    
    // MARK: - Private func
    private func addSubviews() {
        view.addSubview(loader)
    }
    
    private func makeConstraints() {
        loader.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func displayPhotos() {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            self?.provider.fetchPhotos { [weak self] photos, error  in
                guard let photos = photos else { print(error); return }
                self?.photos = photos
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                    self?.loader.stopAnimating()
                    print("reloaded Data")
                }
            }
        }
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
