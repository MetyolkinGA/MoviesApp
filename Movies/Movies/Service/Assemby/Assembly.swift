// Assembly.swift
// Copyright © Movie. All rights reserved.

import UIKit

protocol ApplicationAssembly {
    func createMovieListViewConrtoller() -> UIViewController
    func createDetailedMovieViewController(movieID: String) -> UIViewController
}
