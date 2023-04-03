// MovieCoordinator.swift
// Copyright © Movie. All rights reserved.

import UIKit

final class MovieCoordinator: BaseCoordinator {
    // MARK: - Private Properties

    private let applicationAssembly: ApplicationAssembly
    private let navigationController: UINavigationController

    // MARK: - Life Cycle

    required init(navigationController: UINavigationController, applicationAssembly: ApplicationAssembly) {
        self.applicationAssembly = applicationAssembly
        self.navigationController = navigationController
    }

    override func start() {
        openMovieListModule()
    }

    // MARK: - Internal Methods

    func openMovieDetailedModule(movieID: String) {
        let detailsMovieViewController = applicationAssembly.createDetailsMovieViewController(movieID: movieID)
        navigationController.pushViewController(detailsMovieViewController, animated: true)
    }

    func openMovieListModule() {
        guard
            let movieListViewConrtoller =
            applicationAssembly.createMovieListViewConrtoller() as? MovieListViewController
        else { return }
        movieListViewConrtoller.openDetailedMovieModule = { [weak self] id in
            self?.openMovieDetailedModule(movieID: id)
        }
        navigationController.pushViewController(movieListViewConrtoller, animated: true)
    }
}
