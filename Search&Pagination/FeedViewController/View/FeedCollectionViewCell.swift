//
//  FeedCollectionViewCell.swift
//  Search&Pagination
//
//  Created by Артур Бодров on 09.03.2022.
//

import UIKit
import SnapKit

final class FeedCollectionViewCell: UICollectionViewCell {
    static let identifier = "FeedCollectionViewCell"
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        backgroundColor = .yellow
        addSubviews()
        makeConstraints()
    }
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
   
    private func addSubviews() {
        contentView.addSubview(imageView)
        contentView.addSubview(userNameLabel)
    }

    private func makeConstraints() {
        imageView.snp.makeConstraints {
            $0.size.equalToSuperview()
        }
        userNameLabel.snp.makeConstraints {
            $0.right.bottom.equalToSuperview()
        }
    }
    
    public func setupCell(with photo: Photo) {
        userNameLabel.text = photo.username
        imageView.image = photo.photo
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
