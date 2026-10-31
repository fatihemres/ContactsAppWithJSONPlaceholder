//
//  UserDetailViewModel.swift
//  ContactsAppWithJSONPlaceholder
//
//  Created by Fatih Emre on 20.01.2025.
//

import Foundation

/// Responsible for handling the user data and communicating state changes to the view.
final class UserDetailViewModel: ViewModel {
    // MARK: - Properties
    /// The user object containing details to display.
    private let user: User
    
    /// A callback to notify the view about state changes (e.g., loading, success, or error).
    var stateChangeHandler: Callback<UserDetailViewState>?

    // MARK: - Initialization
    /// Initializes the ViewModel with a `User` object.
    /// - Parameter user: The user whose details will be displayed.
    init(user: User) {
        self.user = user
    }

    // MARK: - Public Methods
    /// Presents the already-selected user without a second network request.
    /// The list flow passes a complete User value to this ViewModel, so
    /// detail presentation must not randomly fail or simulate fetching.
    func loadUserDetails() {
        stateChangeHandler?(.success)
    }

    /// Provides the user object to the view.
    /// - Returns: The `User` object containing details to display.
    func getUser() -> User {
        return user
    }
}
