//
//  SecondVCCoordinator.swift
//  TestUnsplash
//
//  Created by Denis Svetlakov on 06.06.2022.
//

import UIKit


class SecondVCCoordinator: Coordinator, SecondVCFlow {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let secondViewController = SecondViewController()
        secondViewController.coordinator = self
        
        navigationController?.pushViewController(secondViewController, animated: false)
    }
    
    // MARK: - Flow Methods
    func coordinateToDetail(with picture: Photo) {
        let secondVCToDetailCoordinator = FirstVCToDetailCoordinator(navigationController: navigationController!, picture: picture)
        coordinate(to: secondVCToDetailCoordinator)
    }
}
