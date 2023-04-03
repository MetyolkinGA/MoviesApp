// MovieList.swift
// Copyright © Movie. All rights reserved.

import RealmSwift
import UIKit

protocol DomainModelMarkerProtocol {}

/// Список фильмов
struct MovieList: Decodable {
    let results: [Movie]

    enum CodingKeys: String, CodingKey {
        case results
    }
}

/// Информация о конкретнном фильме
class Movie: Object, DomainModelMarkerProtocol, Decodable {
    @Persisted var id: Int
    @Persisted var overview: String
    @Persisted var posterPath: String
    @Persisted var releaseDate: String?
    @Persisted(primaryKey: true) var title: String
    @Persisted var voteAverage: Double
    @Persisted var filter: String
    @Persisted var language: String = L10n.requestLanguage
    var posterURL: String {
        "https://image.tmdb.org/t/p/w500\(posterPath)"
    }

//    init(
//        id: Int,
//        overview: String,
//        posterPath: String,
//        releaseDate: String? = nil,
//        title: String,
//        voteAverage: Double,
//        filter: String,
//        language: String
//    ) {
//        self.id = id
//        self.overview = overview
//        self.posterPath = posterPath
//        self.releaseDate = releaseDate
//        self.title = title
//        self.voteAverage = voteAverage
//        self.filter = filter
//        self.language = language
//    }

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
