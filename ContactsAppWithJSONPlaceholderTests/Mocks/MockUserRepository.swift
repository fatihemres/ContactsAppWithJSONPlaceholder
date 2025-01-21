//
//  MockUserRepository.swift
//  ContactsAppWithJSONPlaceholder
//
//  Created by Fatih Emre on 20.01.2025.
//

import Foundation
@testable import ContactsAppWithJSONPlaceholder

/// A mock implementation of `UserRepositoryProtocol` for testing purposes.
/// This allows controlled responses for testing ViewModels or other components without relying on actual network calls.
final class MockUserRepository: UserRepositoryProtocol {
    var shouldReturnError: Bool = false
    
    var mockUsers: [User] = [MockUser.sample]

    /// Simulates fetching users, returning either a success with mocked data or a failure with a generic error.
    /// - Parameter completion: A completion handler that returns a result containing either a list of `User` objects or a `NetworkError`.
    func fetchUsers(completion: @escaping (Result<[User], NetworkError>) -> Void) {
        if shouldReturnError {
            completion(.failure(.genericError))
        } else {
            completion(.success(mockUsers))
        }
    }
}
