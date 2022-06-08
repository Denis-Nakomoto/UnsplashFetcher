//
//  DetailCoordinator.swift
//  TestUnsplash
//
//  Created by Denis Svetlakov on 06.06.2022.
//

import UIKit

class DetailViewController: UIViewController, AddToFavProtocol {
    
    var coordinator: DetailFlow?
    
    var photo: Photo!
    
    let picture: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let context = StorageService.viewContext
    private let isFavImage = UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22, weight: .medium))
    private let notFavImage = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22, weight: .medium))
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        downloadPicture()
    }
    
    private func downloadPicture() {
        NetworkService.downloadPicture(with: photo) { [unowned self] result, error in
            if let error = error {
                print(error)
                return
            }
            self.setupConstraints(with: result ?? UIImage())
            fillData()
        }
    }
    
    private func fillData() {
        
        if let name = photo.user?.name {
            nameLabel.text = "Author: \(name)"
        }
        if let date = photo.createdAt {
            dateLabel.text = "Created at: \(date)"
        }
        if let likes = photo.likes {
            likesLabel.text = "Likes: \(likes)"
        }
    }
    
    private func setupConstraints(with image: UIImage) {
        view.addSubview(picture)
        view.addSubview(nameLabel)
        view.addSubview(dateLabel)
        view.addSubview(likesLabel)
        view.addSubview(favoriteButton)
        view.bringSubviewToFront(favoriteButton)
        
        var aspectR: CGFloat = 0.0
        aspectR = image.size.width/image.size.height
        picture.image = image
        
        NSLayoutConstraint.activate([
            picture.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            picture.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            picture.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 16),
            picture.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16),
            picture.heightAnchor.constraint(equalTo: picture.widthAnchor, multiplier: 1/aspectR)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: picture.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: picture.leadingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: picture.leadingAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
        
        NSLayoutConstraint.activate([
            likesLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            likesLabel.leadingAnchor.constraint(equalTo: picture.leadingAnchor),
            likesLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
        
        NSLayoutConstraint.activate([
            favoriteButton.trailingAnchor.constraint(equalTo: picture.trailingAnchor, constant: -10),
            favoriteButton.bottomAnchor.constraint(equalTo: picture.bottomAnchor, constant: -10)
        ])
    }
    
    @objc func favoriteAction() {
        favoriteButton.tintColor == .white ? addToFavorites(button: favoriteButton, photo: photo, image: isFavImage!, context: context) : removeFromFavorites(button: favoriteButton, photo: photo, image: notFavImage!, context: context)
    }
    
}


