// DetailedMovieViewModel.swift
// Copyright © Movie. All rights reserved.

protocol DetailedMovieViewModel: AnyObject {
    var updateDataTableView: VoidHandler? { get set }
    var presentErrorAlerController: StringHandler? { get set }
    func configure(movieID: String, movieAPIService: MovieAPIService)
    func getMovie() -> Movie?
}
