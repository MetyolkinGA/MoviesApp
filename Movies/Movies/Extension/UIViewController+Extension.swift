// UIViewController+Extension.swift
// Copyright © Movie. All rights reserved.

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String?, titleAction: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: titleAction, style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}
