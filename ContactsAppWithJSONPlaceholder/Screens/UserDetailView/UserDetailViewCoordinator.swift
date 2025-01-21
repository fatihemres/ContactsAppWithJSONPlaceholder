//
//  UserDetailViewCoordinator.swift
//  ContactsAppWithJSONPlaceholder
//
//  Created by Fatih Emre on 20.01.2025.
//

import UIKit

/// It is responsible for creating the User Detail view and adding it to the navigation stack.
final class UserDetailViewCoordinator: ParentCoordinator {
    /// A list of child coordinators to manage nested flows.
    var childCoordinators: [Coordinator] = []
    
    /// The navigation controller used to present the User Detail view.
    var navigationController: UINavigationController
    
    /// The `User` object containing the details to be displayed.
    private var user: User

    /// Initializes the coordinator with a navigation controller and a user object.
    /// - Parameters:
    ///   - navigationController: The navigation controller managing the view stack.
    ///   - user: The `User` whose details will be displayed.
    init(navigationController: UINavigationController, user: User) {
        self.navigationController = navigationController
        self.user = user
    }

    /// Starts the User Detail flow by building the User Detail view and pushing it onto the navigation stack.
    /// - Parameter animated: Indicates whether the transition to the User Detail screen should be animated.
    func start(animated: Bool) {
        let userDetailVC = UserDetailBuilder(coordinator: self, user: user).build()
        navigationController.pushViewController(userDetailVC, animated: animated)
    }
}
