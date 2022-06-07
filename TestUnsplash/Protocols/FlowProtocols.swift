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
    func coordinateToDetail()
}

protocol SecondVCFlow: AnyObject {
    func coordinateToDetail()
}

protocol DetailFlow: AnyObject {
    func dismissDetail()
}

