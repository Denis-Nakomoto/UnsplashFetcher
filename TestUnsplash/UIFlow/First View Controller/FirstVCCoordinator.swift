//
//  FirstVCCoordinator.swift
//  TestUnsplash
//
//  Created by Denis Svetlakov on 06.06.2022.
//

import UIKit

class FirstVCCoordinator: Coordinator, FirstVCFlow {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let firstViewController = FirstViewController()
        firstViewController.coordinator = self
        
        navigationController?.pushViewController(firstViewController, animated: false)
    }
    
    // MARK: - Flow Methods
    func coordinateToDetail() {
        let firstVCToDetailCoordinator = FirstVCToDetailCoordinator(navigationController: navigationController!)
        coordinate(to: firstVCToDetailCoordinator)
    }
}

