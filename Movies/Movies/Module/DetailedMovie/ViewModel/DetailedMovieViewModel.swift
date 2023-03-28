// DetailedMovieViewModel.swift
// Copyright © Movie. All rights reserved.

protocol DetailedMovieViewModel: AnyObject {
    var reloadTableView: VoidHandler? { get set }
    func getMovie() -> Movie?
    func requestDetailedMovie()
}
