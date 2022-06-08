//
//  UIViewController+Extension.swift
//  TestUnsplash
//
//  Created by Denis Svetlakov on 07.06.2022.
//

import UIKit

extension UIViewController {
    func showAlert(with title: String, and message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
}

