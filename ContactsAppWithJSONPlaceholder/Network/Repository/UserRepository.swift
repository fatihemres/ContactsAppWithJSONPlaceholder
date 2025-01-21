//
//  UserRepository.swift
//  ContactsAppWithJSONPlaceholder
//
//  Created by Fatih Emre on 20.01.2025.
//

import Foundation

/// A protocol for a repository that handles user-related data operations.
protocol UserRepositoryProtocol {
    /**
     Fetches a list of users from the API.
     - Parameters:
        - completion: A closure that receives the result of the fetch operation, either success with a list of `User` objects or a `NetworkError`.
     */
    func fetchUsers(completion: @escaping (Result<[User], NetworkError>) -> Void)
}

/// A repository responsible for fetching user data from the network.
/// Implements the `UserRepositoryProtocol` to decouple data-fetching logic from the rest of the application.
class UserRepository: UserRepositoryProtocol {
    /**
     Fetches a list of users from the API.
     - Parameters:
        - completion: A closure that receives the result of the fetch operation, either success with a list of `User` objects or a `NetworkError`.
     */
    func fetchUsers(completion: @escaping (Result<[User], NetworkError>) -> Void) {
        // Sends a network request to the `users` endpoint.
        NetworkRequest.shared.getData(for: .users) { result in
            switch result {
            case .success(let data):
                do {
                    // Decodes the received JSON data into an array of `User` objects.
                    let users = try JSONDecoder().decode([User].self, from: data)
                    completion(.success(users))
                } catch {
                    completion(.failure(.cannotParseData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
