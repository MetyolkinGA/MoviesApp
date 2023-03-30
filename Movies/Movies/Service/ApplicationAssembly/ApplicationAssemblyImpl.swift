// ApplicationAssemblyImpl.swift
// Copyright © Movie. All rights reserved.

import UIKit

final class ApplicationAssemblyImpl: ApplicationAssembly {
    // MARK: - Internal Methods

    func createMovieListViewConrtoller() -> UIViewController {
        let movieListViewController = MovieListViewController()
        let movieListViewModel = MovieListViewModelImpl()
        movieListViewModel.configure(movieAPIService: MovieAPIServiceImpl())
        movieListViewController.configure(movieListViewModel: movieListViewModel)
        return movieListViewController
    }

    func createDetailsMovieViewController(movieID: String) -> UIViewController {
        let detailsMovieViewController = DetailsMovieViewController()
        let detailsMovieViewModel = DetailsMovieViewModelImpl()
        detailsMovieViewModel.configure(movieID: movieID, movieAPIService: MovieAPIServiceImpl())
        detailsMovieViewController.configure(detailsMovieViewModel: detailsMovieViewModel)
        return detailsMovieViewController
    }
}
