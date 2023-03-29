// BaseCoordinator.swift
// Copyright © Movie. All rights reserved.

import UIKit
/// Базовый координатор
class BaseCoordinator {
    // MARK: - Internal Properties

    var childCoordinator: [BaseCoordinator] = []

    // MARK: - Internal Methods

    func start() {}

    func addDepedency(_ coordinator: BaseCoordinator) {
        for element in childCoordinator where element === coordinator {
            return
        }
        childCoordinator.append(coordinator)
    }

    func setAtRoot(_ controller: UIViewController) {
        UIApplication.shared.keyWindow?.rootViewController = controller
    }
}
