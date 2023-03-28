// MovieListViewModelImpl.swift
// Copyright © Movie. All rights reserved.

import CoreData
import UIKit

final class MovieListViewModelImpl: MovieListViewModel {
    // MARK: - Internal Properties

    var reloadTableView: VoidHandler?

    // MARK: - Private Properties

    private var movies: [Movie]? = []

    private enum Constants {
        static let topRated =
            "https://api.themoviedb.org/3/movie/top_rated?api_key=2f848e32459240f0dee56929f2a129eb&language=ru&page=1"
        static let popular =
            "https://api.themoviedb.org/3/movie/popular?api_key=2f848e32459240f0dee56929f2a129eb&language=ru&page=1"
        static let upcoming =
            "https://api.themoviedb.org/3/movie/upcoming?api_key=2f848e32459240f0dee56929f2a129eb&language=ru&page=1"
    }

    private enum MovieSortSegment: Int {
        case topRate
        case topPopular
        case upComing
    }

    // MARK: - Intenal Methods

    func selectedValue(index: Int) {
        switch MovieSortSegment(rawValue: index) {
            case .topRate:
                getMovie(url: Constants.topRated)
            case .topPopular:
                getMovie(url: Constants.popular)
            case .upComing:
                getMovie(url: Constants.upcoming)
            default:
                return
        }
    }

    func getMovies() -> [Movie] {
        movies ?? []
    }

    // MARK: - Private Methods

    func getMovie(url: String) {
        movies = nil
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self = self, let data = data else { return }
            do {
                let movieList = try JSONDecoder().decode(MovieList.self, from: data)
                self.movies = movieList.results
                DispatchQueue.main.async {
                    self.reloadTableView?()
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
