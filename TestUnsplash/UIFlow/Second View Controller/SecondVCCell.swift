//
//  SecondVCCell.swift
//  TestUnsplash
//
//  Created by Denis Svetlakov on 06.06.2022.
//

import UIKit
import SDWebImage

class SecondViewCell: UITableViewCell {
    
    let pictureThumb: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let nameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
    
    private func setupConstraints() {
        addSubview(pictureThumb)
        addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            pictureThumb.heightAnchor.constraint(equalToConstant: 90),
            pictureThumb.widthAnchor.constraint(equalToConstant: 90),
            pictureThumb.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            pictureThumb.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            nameLabel.leadingAnchor.constraint(equalTo: pictureThumb.trailingAnchor, constant: 10)
        ])
    }
    
    func setupCell(with picture: Photo) {
        pictureThumb.sd_setImage(with: URL(string: picture.urls?.thumb ?? ""),
                                 placeholderImage: UIImage(systemName: "photo"))
        nameLabel.text = picture.user?.name ?? ""
    }
    
}
