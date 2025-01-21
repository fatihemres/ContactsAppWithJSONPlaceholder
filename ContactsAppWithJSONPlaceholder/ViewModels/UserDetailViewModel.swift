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
    /// Simulates loading user details by triggering a state change after a delay.
    /// A random success or failure result is used to mimic network behavior.
    func loadUserDetails() {
        stateChangeHandler?(.loading) // Notify the view that data is being loaded.

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }

            let isSuccess = Bool.random() // Randomly determine success or failure.
            if isSuccess {
                self.stateChangeHandler?(.success) // Notify the view of success.
            } else {
                self.stateChangeHandler?(.error("Failed to fetch user details. Please try again later."))
                // Notify the view of an error with a descriptive message.
            }
        }
    }

    /// Provides the user object to the view.
    /// - Returns: The `User` object containing details to display.
    func getUser() -> User {
        return user
    }
}
