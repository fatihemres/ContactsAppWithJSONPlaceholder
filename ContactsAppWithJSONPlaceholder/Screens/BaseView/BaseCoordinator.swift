//
//  BaseCoordinator.swift
//  ContactsAppWithJSONPlaceholder
//
//  Created by Fatih Emre on 20.01.2025.
//

import UIKit

/// `BaseCoordinator` is the root coordinator of the application, responsible for managing the primary navigation flow.
/// It adheres to both the `Coordinator` and `ParentCoordinator` protocols, allowing it to coordinate between child coordinators and handle their lifecycle.
final class BaseCoordinator: Coordinator, ParentCoordinator {
    /// A list of child coordinators managed by this coordinator.
    /// This allows the `BaseCoordinator` to track and manage the lifecycle of all active flows in the app.
    var childCoordinators: [Coordinator] = []
    
    /// The navigation controller used to manage the view controller stack.
    var navigationController: UINavigationController

    /// Initializes the `BaseCoordinator` with a navigation controller.
    /// - Parameter navigationController: The `UINavigationController` instance to be used for navigation.
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    /// Starts the coordinator by initializing and starting the first child coordinator (`UserListViewCoordinator`).
    /// - Parameter animated: Indicates whether the navigation transition should be animated.
    func start(animated: Bool) {
        let userListCoordinator = UserListViewCoordinator(navigationController: navigationController)
        addChild(userListCoordinator) // Registers the child coordinator to track its lifecycle.
        userListCoordinator.start(animated: animated) // Delegates control to the child coordinator to begin its flow.
    }

    /// Removes a finished child coordinator from the list of active child coordinators.
    /// - Parameter child: The child coordinator that has completed its task.
    func childDidFinish(_ child: Coordinator?) {
        guard let child = child else { return }
        childCoordinators.removeAll { $0 === child } // Ensures the completed coordinator is no longer tracked.
    }
}
