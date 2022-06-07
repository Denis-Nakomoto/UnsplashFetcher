//
//  TabBarCoordinator.swift
//  TestUnsplash
//
//  Created by Denis Svetlakov on 06.06.2022.
//

import UIKit

class TabBarCoordinator: Coordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let tabBarController = TabBarController()
        tabBarController.coordinator = self
        
        let firstNavigationController = UINavigationController()
        firstNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        let firstCoordinator = FirstVCCoordinator(navigationController: firstNavigationController)
        
        let secondNavigationController = UINavigationController()
        secondNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        let secondCoordinator = SecondVCCoordinator(navigationController: secondNavigationController)
        
        tabBarController.viewControllers = [firstNavigationController,
                                            secondNavigationController]
        
        tabBarController.modalPresentationStyle = .fullScreen
        navigationController.present(tabBarController, animated: true, completion: nil)
        
        coordinate(to: firstCoordinator)
        coordinate(to: secondCoordinator)
    }
}
