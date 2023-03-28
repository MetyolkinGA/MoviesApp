// SceneDelegate.swift
// Copyright © Movie. All rights reserved.

import UIKit
/// SceneDelegate
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let movieListViewController = MovieListViewController()
        let movieListViewModel = MovieListViewModelImpl()
        movieListViewModel.configure(movieAPIService: MovieAPIServiceImpl())
        movieListViewController.configure(movieListViewModel: movieListViewModel)
        window.rootViewController = UINavigationController(rootViewController: movieListViewController)
        window.makeKeyAndVisible()
        self.window = window
    }
}
