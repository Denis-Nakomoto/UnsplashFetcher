//
//  AddToFavProtocol.swift
//  TestUnsplash
//
//  Created by Denis Svetlakov on 08.06.2022.
//

import Foundation
import UIKit
import CoreData


protocol AddToFavProtocol {
    func addToFavorites(button: UIButton, photo: Photo?, image: UIImage, context: NSManagedObjectContext)
    func removeFromFavorites(button: UIButton, photo: Photo?, image: UIImage, context: NSManagedObjectContext)
}

extension AddToFavProtocol {
    
    func addToFavorites(button: UIButton, photo: Photo?, image: UIImage, context: NSManagedObjectContext) {
        guard let photo = photo else { return }
        let newFav = CDPicture(context: context)
        newFav.id = photo.id
        StorageService.shared.saveContext()
        button.tintColor = .systemBlue
        button.setImage(image, for: .normal)
    }
    
    func removeFromFavorites(button: UIButton, photo: Photo?, image: UIImage, context: NSManagedObjectContext) {
        guard let photo = photo else { return }
        let cdPicture = StorageService.getBy(id: photo.id ?? "")
        if let cdPicture = cdPicture {
            context.delete(cdPicture)
            StorageService.shared.saveContext()
            button.tintColor = .white
            button.setImage(image, for: .normal)
        }
    }
    
}
