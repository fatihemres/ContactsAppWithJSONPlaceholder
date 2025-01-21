//
//  UserListViewCoordinator.swift
//  ContactsAppWithJSONPlaceholder
//
//  Created by Fatih Emre on 20.01.2025.
//

import UIKit

/// It is responsible for starting the user list flow and handling transitions to the user detail screen.
final class UserListViewCoordinator: ParentCoordinator {
    /// A list of child coordinators to manage nested flows.
    var childCoordinators: [Coordinator] = []
    
    /// The navigation controller used for presenting view controllers in this flow.
    var navigationController: UINavigationController

    /// Initializes the coordinator with a navigation controller.
    /// - Parameter navigationController: The navigation controller that manages the view stack.
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    /// Starts the user list flow by creating and pushing the user list view controller onto the navigation stack.
    /// - Parameter animated: Whether the transition to the user list screen should be animated.
    func start(animated: Bool) {
        let viewController = UserListBuilder(coordinator: self).build() // Builds the user list screen.
        navigationController.pushViewController(viewController, animated: animated)
    }

    /// Navigates to the user detail screen for the selected user.
    /// - Parameter user: The user object to display on the detail screen.
    func goToUserDetailScreen(with user: User) {
        let detailCoordinator = UserDetailViewCoordinator(navigationController: navigationController, user: user)
        addChild(detailCoordinator) // Adds the detail coordinator as a child to manage its lifecycle.
        detailCoordinator.start(animated: true) // Starts the detail flow.
    }
}
