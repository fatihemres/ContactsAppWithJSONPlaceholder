//
//  UsersListViewViewModelDelegate.swift
//  ContactsAppWithJSONPlaceholder
//
//  Created by Fatih Emre on 20.01.2025.
//

import UIKit

protocol UsersListViewModelDelegate: AnyObject {
    func didSelectUser(_ user: User)
}

/// Handles data fetching, search functionality, and communication with the view via state changes.
final class UsersListViewModel: ViewModel {
    // MARK: - Properties
    /// Delegate to handle user selection actions.
    weak var delegate: UsersListViewModelDelegate?
    
    /// A callback to notify the view about state changes (e.g., loading, success, empty, error).
    var stateChangeHandler: Callback<UsersListViewState>?
    
    /// The repository responsible for fetching user data.
    private let userRepository: UserRepositoryProtocol
    
    /// Tracks the current loading state to avoid duplicate fetch calls.
    private var isLoading: Bool = false
    
    /// The list of all users fetched from the repository.
    private var users: [User] = [] {
        didSet {
            updateFilteredUsers() // Updates the filtered users whenever the main list changes.
        }
    }
    
    /// The filtered list of users based on search queries.
    private var filteredUsers: [User] = []

    // MARK: - Initialization
    /// Initializes the ViewModel with a user repository.
    /// - Parameter userRepository: The repository used for fetching user data. Defaults to `UserRepository`.
    init(userRepository: UserRepositoryProtocol = UserRepository()) {
        self.userRepository = userRepository
    }

    // MARK: - Public Methods
    /// Starts the ViewModel by fetching the initial list of users.
    func start() {
        fetchUsers()
    }

    /// Returns the number of rows based on the filtered users.
    /// - Returns: The count of filtered users.
    func numberOfRows() -> Int {
        return filteredUsers.count
    }

    /// Returns a user object at the specified index.
    /// - Parameter index: The index of the user in the filtered list.
    /// - Returns: The `User` object if the index is valid, otherwise `nil`.
    func user(at index: Int) -> User? {
        return filteredUsers.indices.contains(index) ? filteredUsers[index] : nil
    }

    /// Filters the users based on a search query.
    /// - Parameter query: The search query string.
    func searchUsers(with query: String?) {
        guard let query = query, !query.isEmpty else {
            updateFilteredUsers() // Reset to the full user list if the query is empty.
            return
        }
        filteredUsers = users.filter { $0.name.lowercased().contains(query.lowercased()) }
        stateChangeHandler?(filteredUsers.isEmpty ? .empty : .success)
    }

    // MARK: - Private Methods
    /// Fetches the list of users from the repository.
    private func fetchUsers() {
        guard !isLoading else { return }
        isLoading = true
        stateChangeHandler?(.loading) // Notify the view that data is being loaded.

        userRepository.fetchUsers { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false

            switch result {
            case .success(let fetchedUsers):
                self.users = fetchedUsers
                self.stateChangeHandler?(self.users.isEmpty ? .empty : .success)
            case .failure(let error):
                self.stateChangeHandler?(.error(error.localizedDescription)) // Notify the view of an error.
            }
        }
    }

    /// Updates the filtered users to match the full user list.
    private func updateFilteredUsers() {
        filteredUsers = users
        stateChangeHandler?(users.isEmpty ? .empty : .success) // Notify the view of the current state.
    }
}
