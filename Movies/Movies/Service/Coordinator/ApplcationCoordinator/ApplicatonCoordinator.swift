// ApplicatonCoordinator.swift
// Copyright © Movie. All rights reserved.

import UIKit

final class ApplicatonCoordinator: BaseCoordinator {
    // MARK: - Private Properties

    private var navigationController: UINavigationController?
    private var applicationAssembly: ApplicationAssembly

    // MARK: - Life Cycle

    required init(navigationController: UINavigationController, applicationAssembly: ApplicationAssembly) {
        self.navigationController = navigationController
        self.applicationAssembly = applicationAssembly
    }

    override func start() {
        openMovieListModule()
    }

    // MARK: - Private Methods

    private func openMovieListModule() {
        let movieCoordinator = MovieCoordinator(
            navigationController: navigationController ?? UINavigationController(),
            applicationAssembly: applicationAssembly
        )
        childCoordinator.append(movieCoordinator)
        movieCoordinator.start()
    }
}
