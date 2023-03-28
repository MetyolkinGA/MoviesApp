// AssemblyImpl.swift
// Copyright © Movie. All rights reserved.

import UIKit

final class AssemblyImpl: Assembly {
    // MARK: - Internal Methods

    func createMovieListViewConrtoller() -> UIViewController {
        let movieListViewController = MovieListViewController()
        let movieListViewModel = MovieListViewModelImpl()
        movieListViewModel.configure(movieAPIService: MovieAPIServiceImpl())
        movieListViewController.configure(movieListViewModel: movieListViewModel)
        return movieListViewController
    }

    func createDetailedMovieViewController(movieID: String) -> UIViewController {
        let detailedMovieViewController = DetailedMovieViewController()
        let detailedMovieViewModel = DetailedMovieViewModelImpl()
        detailedMovieViewModel.configure(movieID: movieID, movieAPIService: MovieAPIServiceImpl())
        detailedMovieViewController.configure(detailedMovieViewModel: detailedMovieViewModel)
        return detailedMovieViewController
    }
}
