//
//  FirstVCItem.swift
//  TestUnsplash
//
//  Created by Denis Svetlakov on 06.06.2022.
//

import UIKit
import SDWebImage

class FirstVCItem: UICollectionViewCell, AddToFavProtocol {
    
    let picture: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .white
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        let image = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22, weight: .medium))
        button.tintColor = .white
        button.backgroundColor = .clear
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(favoriteAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var favorites: [CDPicture]?
    
    var photo: Photo?
    
    private let context = StorageService.viewContext
    private let isFavImage = UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22, weight: .medium))
    private let notFavImage = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22, weight: .medium))

    override init(frame: CGRect) {
        super.init (frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
    
    private func setupConstraints() {
        addSubview(picture)
        contentView.addSubview(favoriteButton)
        bringSubviewToFront(favoriteButton)
        
        NSLayoutConstraint.activate([
            picture.topAnchor.constraint(equalTo: topAnchor),
            picture.trailingAnchor.constraint(equalTo: trailingAnchor),
            picture.leadingAnchor.constraint(equalTo: leadingAnchor),
            picture.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            favoriteButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    @objc func favoriteAction() {
        favoriteButton.tintColor == .white ? addToFavorites(button: favoriteButton, photo: photo, image: isFavImage!, context: context) : removeFromFavorites(button: favoriteButton, photo: photo, image: notFavImage!, context: context)
    }

    private func setupFavorites() {
        guard let photo = photo else { return }
        guard let favorites = favorites else { return }
        if favorites.contains(where: { $0.id == photo.id }) {
            favoriteButton.tintColor = .systemBlue
            favoriteButton.setImage(isFavImage, for: .normal)
        } else {
            favoriteButton.tintColor = .white
            favoriteButton.setImage(notFavImage, for: .normal)
        }
    }
    
    func setPicture(with url: String) {
        picture.sd_setImage(with: URL(string: url), placeholderImage: UIImage(systemName: "photo"))
        setupFavorites()
    }
}


