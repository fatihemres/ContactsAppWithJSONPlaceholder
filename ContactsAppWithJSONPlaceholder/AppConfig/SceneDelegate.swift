//
//  SceneDelegate.swift
//  ContactsAppWithJSONPlaceholder
//
//  Created by Fatih Emre on 20.01.2025.
//

import UIKit

/// The storyboard has been removed, so the app's launch process is fully handled programmatically.
/// This method initializes the window and sets up the navigation flow using `BaseCoordinator`.
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var baseCoordinator: BaseCoordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Initialize a navigation controller to manage the view controllers.
        let navigationController = UINavigationController()
        
        // Set up the app's navigation flow with `BaseCoordinator`.
        baseCoordinator = BaseCoordinator(navigationController: navigationController)
        baseCoordinator?.start(animated: true)
        
        // Create the app's main window programmatically.
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController // Attach the navigation controller to the window.
        self.window = window
        window.makeKeyAndVisible() // Display the window on the screen.
    }
}
