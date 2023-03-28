// DetailedMovieViewModelImpl.swift
// Copyright © Movie. All rights reserved.

import UIKit

final class DetailedMovieViewModelImpl: DetailedMovieViewModel {
    // MARK: - Intenal Properties

    var reloadTableView: VoidHandler?

    // MARK: - Private Properties

    private var movie: Movie?

    private enum Constants {
        static let url =
            "https://api.themoviedb.org/3/movie/238?api_key=2f848e32459240f0dee56929f2a129eb&language=ru"
    }

    // MARK: - Internal Methods

    func getMovie() -> Movie? {
        movie
    }

    func requestDetailedMovie() {
        guard let url = URL(string: Constants.url) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self = self, let data = data else { return }
            do {
                let movie = try JSONDecoder().decode(Movie.self, from: data)
                self.movie = movie
                DispatchQueue.main.async {
                    self.reloadTableView?()
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
