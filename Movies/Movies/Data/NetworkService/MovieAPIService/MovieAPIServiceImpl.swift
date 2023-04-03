// MovieAPIServiceImpl.swift
// Copyright © Movie. All rights reserved.

import Foundation

final class MovieAPIServiceImpl: MovieAPIService {
    // MARK: - Private Properties

    private enum URLComponentsConstants {
        static let scheme = "https"
        static let host = "api.themoviedb.org"
        static let path = "/3/movie/"
        static let apiKey = "api_key"
        static let apiKeyValue = "2f848e32459240f0dee56929f2a129eb"
        static let language = "language"
    }

    // MARK: - Internal Methods

    func getMovieList(path: String, completion: @escaping (Result<[Movie], Error>) -> ()) {
        guard let url = createURL(path: path) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data else { return }
            do {
                let movies = try JSONDecoder().decode(MovieList.self, from: data)
                completion(.success(movies.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func getDetailedMovie(path: String, completion: @escaping (Result<Movie, Error>) -> ()) {
        guard let url = createURL(path: path) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data else { return }
            do {
                let movie = try JSONDecoder().decode(Movie.self, from: data)
                completion(.success(movie))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    // MARK: - Private Methods

    private func createURL(path: String) -> URL? {
        var components = URLComponents()
        components.scheme = URLComponentsConstants.scheme
        components.host = URLComponentsConstants.host
        components.path = URLComponentsConstants.path + path
        components.queryItems = [
            URLQueryItem(name: URLComponentsConstants.apiKey, value: URLComponentsConstants.apiKeyValue),
            URLQueryItem(name: URLComponentsConstants.language, value: L10n.requestLanguage)
        ]
        return components.url
    }
}
