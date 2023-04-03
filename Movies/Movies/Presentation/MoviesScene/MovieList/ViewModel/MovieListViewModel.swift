// MovieListViewModel.swift
// Copyright © Movie. All rights reserved.

import UIKit

protocol MovieListViewModel: AnyObject {
    var updateDataTableView: VoidHandler? { get set }
    var showError: StringHandler? { get set }

    func selectedValue(index: Int)
    func getMovies() -> [Movie]
}
