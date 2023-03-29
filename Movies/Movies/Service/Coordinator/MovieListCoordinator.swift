// MovieListCoordinator.swift
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

    func openMovieDetailedModule() {
        guard
            let movieListViewConrtoller =
            applicationAssembly.createMovieListViewConrtoller() as? MovieListViewController
        else { return }
        movieListViewConrtoller.openDetailedMovieModule = { [weak self] id in
            let detailedMovieViewController =
                self?.applicationAssembly.createDetailedMovieViewController(movieID: id)
            self?.navigationController.pushViewController(
                detailedMovieViewController ?? UIViewController(),
                animated: true
            )
        }
    }

    func openMovieListModule() {
        guard
            let movieListViewConrtoller =
            applicationAssembly.createMovieListViewConrtoller() as? MovieListViewController
        else { return }
        movieListViewConrtoller.openDetailedMovieModule = { [weak self] id in
            let detailedMovieViewController =
                self?.applicationAssembly.createDetailedMovieViewController(movieID: id)
            self?.navigationController.pushViewController(
                detailedMovieViewController ?? UIViewController(),
                animated: true
            )
        }
        navigationController.pushViewController(movieListViewConrtoller, animated: true)
    }
}
