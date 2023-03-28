// MovieListViewModelImpl.swift
// Copyright © Movie. All rights reserved.

import CoreData
import UIKit

final class MovieListViewModelImpl: MovieListViewModel {
    // MARK: - Internal Properties

    var updateDataTableView: VoidHandler?
    var presentErrorAlerController: StringHandler?

    // MARK: - Private Properties

    private var movieAPIService: MovieAPIService?
    private var movies: [Movie]? = []

    private enum Constants {
        static let topRated = "top_rated"
        static let popular = "popular"
        static let upcoming = "upcoming"
    }

    private enum MovieSortSegment: Int {
        case topRate
        case topPopular
        case upComing
    }

    // MARK: - Intenal Methods

    func configure(movieAPIService: MovieAPIService) {
        self.movieAPIService = movieAPIService
        selectedValue(index: 0)
    }

    func selectedValue(index: Int) {
        switch MovieSortSegment(rawValue: index) {
            case .topRate:
                loadMoviesData(path: Constants.topRated)
            case .topPopular:
                loadMoviesData(path: Constants.popular)
            case .upComing:
                loadMoviesData(path: Constants.upcoming)
            default:
                return
        }
    }

    func getMovies() -> [Movie] {
        movies ?? []
    }

    // MARK: - Private Methods

    private func loadMoviesData(path: String) {
        movieAPIService?.getMovieList(path: path) { [weak self] result in
            guard let self = self else { return }
            switch result {
                case let .success(movies):
                    self.movies = movies
                    self.updateDataTableView?()
                case let .failure(error):
                    self.presentErrorAlerController?(error.localizedDescription)
            }
        }
    }
}
