// MovieListViewModel.swift
// Copyright © Movie. All rights reserved.

import UIKit

protocol MovieListViewModel: AnyObject {
    var reloadTableView: VoidHandler? { get set }
    func selectedValue(index: Int)
    func getMovies() -> [Movie]
}
