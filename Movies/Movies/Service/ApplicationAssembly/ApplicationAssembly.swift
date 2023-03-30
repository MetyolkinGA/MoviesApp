// ApplicationAssembly.swift
// Copyright © Movie. All rights reserved.

import UIKit

protocol ApplicationAssembly {
    func createMovieListViewConrtoller() -> UIViewController
    func createDetailsMovieViewController(movieID: String) -> UIViewController
}
