// Assembly.swift
// Copyright © Movie. All rights reserved.

import UIKit

protocol Assembly {
    func createMovieListViewConrtoller() -> UIViewController
    func createDetailedMovieViewController(movieID: String) -> UIViewController
}
