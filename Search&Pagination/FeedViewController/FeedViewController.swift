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
    private var viewModels: [FeedCollectionViewModel] = []
    
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
    
    unowned let interactor: FeedInteractor

    // MARK: - Life Cycle
    
    init(interactor: FeedInteractor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = collectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        makeConstraints()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        loader.startAnimating()
        interactor.fetchPhotos()
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
    
    // MARK: - Public functions
    public func displayPhotos(_ viewModels: [FeedCollectionViewModel]) {
        self.viewModels = viewModels
        
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
            self?.loader.stopAnimating()
        }
    }
    
    public func displayError(_ error: Error) {
        print(error)
    }
}

// MARK: - Delegate & Data Source
extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCollectionViewCell.identifier, for: indexPath) as? FeedCollectionViewCell
        else { return UICollectionViewCell() }
        cell.setupCell(with: viewModels[indexPath.row])
        
        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 400, height: 300)
    }
}
