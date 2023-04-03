// CoreDataSave.swift
// Copyright © Movie. All rights reserved.

import CoreData

final class CoreDataSave {
    // MARK: - Internal Methods

    func saveMovieList(object: [Movie]?, argumentForPredicateGenre: String?, context: NSManagedObjectContext) {
        object?.forEach { movie in
            let resultsObject = MovieCoreDataModel(context: context)
            resultsObject.posterPath = movie.posterPath
            resultsObject.id = Int64(movie.id)
            resultsObject.overview = movie.overview
            resultsObject.title = movie.title
            resultsObject.releaseDate = movie.releaseDate
            resultsObject.voteAverage = movie.voteAverage
            resultsObject.language = L10n.requestLanguage
            resultsObject.filter = movie.filter
        }
    }
}
