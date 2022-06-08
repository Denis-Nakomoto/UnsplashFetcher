//
//  StartProtocol.swift
//  TestUnsplash
//
//  Created by Denis Svetlakov on 06.06.2022.
//

import Foundation

protocol StartFlow: AnyObject {
    func coordinateToTabBar()
}

protocol FirstVCFlow: AnyObject {
    func coordinateToDetail(with picture: Photo)
}

protocol SecondVCFlow: AnyObject {
    func coordinateToDetail(with picture: Photo)
}

protocol DetailFlow: AnyObject {
    func dismissDetail()
}

