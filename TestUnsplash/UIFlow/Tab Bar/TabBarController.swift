//
//  TabBarController.swift
//  TestUnsplash
//
//  Created by Denis Svetlakov on 06.06.2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    var coordinator: TabBarCoordinator?
    
    override func viewDidLoad() {
        self.tabBar.layer.masksToBounds = true
        self.tabBar.barStyle = .black
        self.tabBar.barTintColor = .white
        self.tabBar.tintColor = UIColor.orange
        
        self.tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.tabBar.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        self.tabBar.layer.shadowRadius = 10
        self.tabBar.layer.shadowOpacity = 1
        self.tabBar.layer.masksToBounds = false
    }
    
}
