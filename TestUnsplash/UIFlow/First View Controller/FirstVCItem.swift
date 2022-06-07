//
//  FirstVCItem.swift
//  TestUnsplash
//
//  Created by Denis Svetlakov on 06.06.2022.
//

import UIKit
import SDWebImage

class FirstVCItem: UICollectionViewCell {
    
    var picture: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.shadowRadius = 10
        imageView.layer.shadowOpacity = 0.3
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init (frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
    
    private func setupConstraints() {
        addSubview(picture)
        NSLayoutConstraint.activate([
            picture.topAnchor.constraint(equalTo: topAnchor),
            picture.trailingAnchor.constraint(equalTo: trailingAnchor),
            picture.leadingAnchor.constraint(equalTo: leadingAnchor),
            picture.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func setPicture(with url: String) {
        picture.sd_setImage(with: URL(string: url), placeholderImage: UIImage(systemName: "photo"))
    }
}


