// SceneDelegate.swift
// Copyright © Movie. All rights reserved.

import UIKit
/// SceneDelegate
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var applicatonCoordinator: ApplicatonCoordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UINavigationController()
        applicatonCoordinator = ApplicatonCoordinator(
            navigationController: window.rootViewController as? UINavigationController ?? UINavigationController(),
            applicationAssembly: ApplicationAssemblyImpl()
        )
        applicatonCoordinator?.start()
        window.makeKeyAndVisible()
        self.window = window
    }
}
