// DetailedMovieViewModelImpl.swift
// Copyright © Movie. All rights reserved.

import UIKit

final class DetailedMovieViewModelImpl: DetailedMovieViewModel {
    // MARK: - Intenal Properties

    var updateDataTableView: VoidHandler?
    var presentErrorAlerController: StringHandler?

    // MARK: - Private Properties

    private var movieID: String?
    private var movie: Movie?
    private var movieAPIService: MovieAPIService?

    // MARK: - Internal Methods

    func configure(movieID: String, movieAPIService: MovieAPIService) {
        self.movieAPIService = movieAPIService
        self.movieID = movieID
        loadDetailedMovieData()
    }

    func getMovie() -> Movie? {
        movie
    }

    // MARK: - Private Methods

    private func loadDetailedMovieData() {
        movieAPIService?.getDetailedMovie(path: movieID ?? String()) { [weak self] result in
            guard let self = self else { return }
            switch result {
                case let .success(movie):
                    self.movie = movie
                    print(movie)
                    DispatchQueue.main.async {
                        self.updateDataTableView?()
                    }
                case let .failure(error):
                    self.presentErrorAlerController?(error.localizedDescription)
            }
        }
    }
}
