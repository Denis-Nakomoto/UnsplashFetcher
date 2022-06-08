//
//  FirstVCToDetailCoordinator.swift
//  TestUnsplash
//
//  Created by Denis Svetlakov on 06.06.2022.
//

import UIKit

class FirstVCToDetailCoordinator: Coordinator, DetailFlow {
    
    let navigationController: UINavigationController
    let picture: Photo
    
    init(navigationController: UINavigationController, picture: Photo) {
        self.navigationController = navigationController
        self.picture = picture
    }
    
    func start() {
        let detailViewController = DetailViewController()
        detailViewController.coordinator = self
        detailViewController.photo = picture
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    // MARK: - Flow Methods
    func dismissDetail() {
        navigationController.dismiss(animated: true, completion: nil)
    }
}
