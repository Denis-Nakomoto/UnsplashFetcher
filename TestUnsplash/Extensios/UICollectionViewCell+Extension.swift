//
//  UICollectionViewCell+Extension.swift
//  TestUnsplash
//
//  Created by Denis Svetlakov on 06.06.2022.
//

import UIKit

extension UICollectionViewCell {
    
    static var reuseId: String {
        String(describing: self)
    }
    
}
