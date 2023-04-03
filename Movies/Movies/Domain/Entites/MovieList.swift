// MovieList.swift
// Copyright © Movie. All rights reserved.

import UIKit

/// Список фильмов
struct MovieList: Decodable {
    let results: [Movie]

    enum CodingKeys: String, CodingKey {
        case results
    }
}

/// Информация о конкретнном фильме
struct Movie: Decodable {
    let id: Int
    let overview: String
    let posterPath: String
    let releaseDate: String?
    let title: String
    let voteAverage: Double
    var posterURL: String {
        "https://image.tmdb.org/t/p/w500\(posterPath)"
    }

    enum CodingKeys: String, CodingKey {
        case id
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
    }

    /// Цвет для рейтинга фильма в зависимости от цифры рейтинга
    var ratingMovieColor: UIColor {
        switch voteAverage {
            case _ where voteAverage < 5:
                return .red
            case _ where voteAverage > 6.9:
                return .green
            default:
                return .gray
        }
    }
}
