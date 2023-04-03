// MovieAPIService.swift
// Copyright © Movie. All rights reserved.

protocol MovieAPIService {
    func getMovieList(path: String, completion: @escaping (Result<[Movie], Error>) -> ())
    func getDetailedMovie(path: String, completion: @escaping (Result<Movie, Error>) -> ())
}